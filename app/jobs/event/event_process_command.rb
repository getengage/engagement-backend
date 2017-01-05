module Event
  class EventProcessCommand < ActiveJob::Base
    queue_as 'default'

    before_perform do |job|
      @old_import  = Import.latest
      @new_import  = Import.create(start_time: Time.current, cutoff: 30.minutes.ago)
    end

    after_perform do |job|
      @new_import.end_time = Time.current
      @new_import.successful!
    end

    # ActiveRecord::Batches#find_in_batches doesn't allow select DISTINCT ON
    # creates a pg CURSOR and fetches blocks of 1000 rows until result set exhausted.
    def perform
      Event::EventsRaw.transaction do
        begin
          cursor = PostgreSQLCursor::Cursor.new(sql, {})
          cursor.open
          while row = cursor.fetch_block
            Sidekiq::Client.push_bulk("queue" => "go_queue",
                                      "class" => "EventProcessWorker",
                                      "args"  => row.map{|x|[x]}) # fix this
            break if row.size < 1000
          end
        ensure
          cursor.close
        end
      end
    end

    protected
    def sql
      @sql ||= Event::EventsRaw.
        by_date_range(@old_import.cutoff, @new_import.cutoff).
        with_aggregates.
        to_sql
    end
  end
end
