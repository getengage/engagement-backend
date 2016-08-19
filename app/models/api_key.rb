class ApiKey < ActiveRecord::Base
  acts_as_paranoid column: :expired_at

  has_one :client_api_key
  has_one :client, through: :client_api_keys

  def display_name
    name.titleize
  end

  # UPDATE
  def uuid
    "1234"
  end
end
