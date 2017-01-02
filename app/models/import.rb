class Import < ActiveRecord::Base
  enum status: [:in_progress, :successful, :failed]

  scope :latest, -> {
    successful.order(created_at: :desc).limit(1).take
  }
end
