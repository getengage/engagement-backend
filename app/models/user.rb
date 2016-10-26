class User < ActiveRecord::Base
  belongs_to :client
  has_many :client_api_keys, foreign_key: :client_id, primary_key: :client_id
  has_many :api_keys, through: :client_api_keys
  has_many :report_summaries, class_name: "Report::Summary"

  enum role: [:user, :vip, :admin]
  enum permissions: [:allow_all, :no_emails]
  after_initialize :set_default_role, if: :new_record?

  mount_uploader :avatar, AvatarUploader

  def set_default_role
    self.role ||= :user
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
end
