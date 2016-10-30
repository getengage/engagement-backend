class ApiKey < ActiveRecord::Base
  include Reportable

  acts_as_paranoid column: :expired_at

  has_one :client_api_key
  has_one :client, through: :client_api_key

  def display_name
    name.titleize
  end
end
