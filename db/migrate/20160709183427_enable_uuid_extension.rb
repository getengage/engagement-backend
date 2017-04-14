class EnableUuidExtension < ActiveRecord::Migration[4.1]
  def change
    enable_extension 'uuid-ossp'
  end
end
