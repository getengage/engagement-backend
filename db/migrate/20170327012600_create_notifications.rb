class CreateNotifications < ActiveRecord::Migration[4.2]
  def change
    change_table :users do |t|
      t.jsonb :metadata, null: false, default: '{}'
    end

    add_index :users, :metadata, using: :gin

    create_table :notifications do |t|
      t.jsonb :data, null: false, default: '{}'
      t.string :url
      t.string :created_by, null: false
      t.references :client
      t.string :type, null: false
      t.timestamps
    end
  end
end
