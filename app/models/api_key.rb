class ApiKey < ApplicationRecord
  include Reportable
  # acts_as_paranoid column: :expired_at

  has_one :client_api_key
  has_one :client, through: :client_api_key
  has_many :events_raw, class_name: "Event::EventsRaw", primary_key: :uuid
  has_many :events_processed, class_name: "Event::EventsProcessed", primary_key: :uuid

  def display_name
    name.titleize
  end
end
