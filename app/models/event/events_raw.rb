module Event
  class EventsRaw < ActiveRecord::Base
    def self.partition_key
      "date_part('month', NEW.timestamp)"
    end

    # the number of the month within the year (1 - 12)
    scope :by_month, ->(month) {
      where("date_part('month', timestamp) = ?", month)
    }

    # time ranges in UTC
    scope :by_date_range, ->(start_date, end_date) {
      by_month(end_date.month).where(timestamp: start_date..end_date)
    }

    scope :with_aggregates, -> {
      select(
        "distinct on (timestamp) *,
        row_number() over (partition by timestamp) as rownum,
        json_agg(x_pos) over (partition by timestamp) as x_pos_arr,
        json_agg(y_pos) over (partition by timestamp) as y_pos_arr,
        json_agg(in_viewport) over (partition by timestamp) as in_viewport_arr,
        json_agg(is_visible) over (partition by timestamp) as is_visible_arr,
        count(id) over (partition by timestamp) as count"
      )
    }

    include Base
  end
end
