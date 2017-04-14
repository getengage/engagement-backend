class CreateApiKeys < ActiveRecord::Migration[4.1]
  def change
    create_table :api_keys do |t|
      t.string :name, null: false
      t.uuid :uuid, default: 'uuid_generate_v4()', null: false, index: true
      t.datetime :expired_at
      t.timestamps
    end
  end
end
