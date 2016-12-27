module Event
  class ByApiKey < ActiveRecord::Base
    self.abstract_class = true
    belongs_to :api_key

    def self.partition_foreign_key
      "api_key"
    end
  end
end
