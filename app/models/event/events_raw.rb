module Event
  class EventsRaw < ActiveRecord::Base
    def self.partition_key
      "date_part('month', NEW.timestamp)"
    end

    # the number of the month within the year (1 - 12)
    scope :by_month, ->(month) {
      where("date_part('month', timestamp) = ?", month)
    }

    include Base
  end
end
