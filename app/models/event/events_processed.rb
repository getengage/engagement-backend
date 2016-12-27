module Event
  class EventsProcessed < ActiveRecord::Base
    belongs_to :api_key
    self.table_name = "events_processed"
  end
end
