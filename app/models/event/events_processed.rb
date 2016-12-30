module Event
  class EventsProcessed < ActiveRecord::Base
    def self.partition_key
      'NEW.api_key_id'
    end

    include Base
  end
end
