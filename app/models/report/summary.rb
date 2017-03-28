module Report
  class Summary < ActiveRecord::Base
    belongs_to :user
    belongs_to :api_key
    enum frequency: [:daily, :weekly]
  end
end
