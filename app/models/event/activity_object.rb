module Event
  class ActivityObject < Hashie::Trash
    property "created_at", from: "time", with: ->(value) { DateTime.parse(value).to_s(:date_and_time) }
    property "api_key"
    property "is_visible"
    property "referrer"
    property "session_id"
    property "source_url"
    property "x_pos"
    property "y_pos"
  end
end
