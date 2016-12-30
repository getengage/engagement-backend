class CreateEventsRaw < ActiveRecord::Migration
  def change
    create_table :events_raw do |t|
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
      t.string :api_key_id
      t.string :session_id
      t.string :source_url
      t.datetime :created_at
    end
  end
end
