class ClientApiKey < ActiveRecord::Base
  belongs_to :client
  belongs_to :api_key
end
