module Event
  class EventsRaw < ActiveRecord::Base
    def self.partition_key
      "date_part('month', NEW.created_at)"
    end

    include Base
  end
end
