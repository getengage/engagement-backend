module Event
  module Base
    extend ActiveSupport::Concern
    included do
      belongs_to :api_key, primary_key: :uuid
      self.table_name = self.table_name.singularize
    end
  end
end
