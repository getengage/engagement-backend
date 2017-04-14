class ClientApiKey < ApplicationRecord
  belongs_to :client
  belongs_to :api_key
end
