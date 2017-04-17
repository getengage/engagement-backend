class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.sanitize(object)
    connection.quote(object)
  end
end
