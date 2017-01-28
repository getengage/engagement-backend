require "#{Rails.root}/lib/simple_pg_cursor"

# ActiveRecord::Batches#find_in_batches doesn't allow select DISTINCT ON, so
# this creates a pg CURSOR and fetches blocks of 100 rows until result set exhausted.
# Sidekiq Pro batches would be helpful here - writing processed events
# to csv(s) or non WAL-logged tables and then doing a pg COPY after batch finishes

module Event
  class EventProcessCommand < ActiveJob::Base
    queue_as 'go_queue'

    before_perform do |job|
      @old_import  = Import.latest
      @new_import  = Import.create(start_time: Time.current, cutoff: 30.minutes.ago)
      Rails.logger.info "(event import - start) time=#{Date.current} queue=#{job.queue_name}"
    end

    after_perform do |job|
      @new_import.end_time = Time.current
      @new_import.successful!
      Rails.logger.info "(event import - end) time=#{Date.current} queue=#{job.queue_name}"
    end

    def perform
      SimplePgCursor.new(Event::EventsRaw, sql).run do |block|
        args = {
          "queue" => "go_queue",
          "class" => "EventProcessWorker",
          "args"  => block
        }
        Sidekiq::Client.push(args)
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
