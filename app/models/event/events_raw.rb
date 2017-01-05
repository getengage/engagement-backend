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
        "distinct on (session_id, timestamp) *,
        array_agg(x_pos) over (partition by session_id, timestamp order by id) as x_pos_arr,
        array_agg(y_pos) over (partition by session_id, timestamp) as y_pos_arr,
        array_agg(in_viewport) over (partition by session_id, timestamp) as in_viewport_arr,
        array_agg(is_visible) over (partition by session_id, timestamp) as is_visible_arr"
      )
    }

    include Base
  end
end
