class CreateClientApiKey < ActiveRecord::Migration[4.1]
  def change
    create_table :client_api_keys, id: false do |t|
      t.references :client, index: true, null: false
      t.references :api_key, index: true, null: false, unique: true
    end
  end
end
