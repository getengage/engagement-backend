class CreateEventsRaw < ActiveRecord::Migration[4.1]
  def change
    create_table :events_raw do |t|
      t.datetime :timestamp, null: false
      t.string :referrer
      t.float :x_pos
      t.float :y_pos
      t.boolean :is_visible
      t.boolean :in_viewport
      t.float :top
      t.float :bottom
      t.integer :word_count
      t.string :remote_ip
      t.string :user_agent
      t.string :api_key_id, null: false
      t.string :session_id, null: false
      t.string :source_url, null: false
      t.datetime :created_at
    end
  end
end
