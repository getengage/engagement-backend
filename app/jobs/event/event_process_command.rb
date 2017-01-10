require "#{Rails.root}/lib/simple_pg_cursor"

module Event
  class EventProcessCommand < ActiveJob::Base
    queue_as 'go_queue'

    before_perform do |job|
      @old_import  = Import.latest
      @new_import  = Import.create(start_time: Time.current, cutoff: 30.minutes.ago)
    end

    after_perform do |job|
      @new_import.end_time = Time.current
      @new_import.successful!
    end

    # ActiveRecord::Batches#find_in_batches doesn't allow select DISTINCT ON
    # creates a pg CURSOR and fetches blocks of 100 rows until result set exhausted.
    def perform
      SimplePgCursor.new(Event::EventsRaw, sql).run do |block|
        args = {
          "queue" => "go_queue",
          "class" => "EventProcessWorker",
          "args"  => block.map{|x| Array.wrap(x) }
        }
        Sidekiq::Client.push_bulk(args)
      end
    end

    protected
    def sql
      return Event::EventsRaw.with_aggregates.limit(4).to_sql if Rails.env.development?
      Event::EventsRaw.
        by_month(Date.current.month).
        by_date_range(@old_import.cutoff, @new_import.cutoff).
        with_aggregates.
        to_sql
    end
  end
end
