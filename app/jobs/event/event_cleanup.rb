module Event
  class EventProcessJob < ActiveJob::Base
    queue_as 'default'

    def perform(month)
      ActiveRecord::Base.connection.execute("TRUNCATE events_raw_#{month} RESTART IDENTITY")
    end
  end
end
