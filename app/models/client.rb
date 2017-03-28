class Client < ActiveRecord::Base
  validates_presence_of :name

  has_many :users
  has_many :client_api_keys
  has_many :api_keys, through: :client_api_keys
  has_many :notifications, class_name: "Notification::Base"

  def all_notifications
    Notification::Base.where(client_id: [nil, id])
  end
end
