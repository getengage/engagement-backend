module Event
  class EventCleanup < ActiveJob::Base
    queue_as 'go_queue'

    def perform(month)
      ActiveRecord::Base.connection.execute("TRUNCATE events_raw_#{month} RESTART IDENTITY")
    end
  end
end
