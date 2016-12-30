class CreateEventsProcessed < ActiveRecord::Migration
  def change
    create_table :events_processed do |t|
      t.string :api_key_id, null: false, index: true
      t.string :source_url, null: false, index: true
      t.string :session_id
      t.string :referrer
      t.boolean :reached_end_of_content
      t.integer :total_in_viewport_time
      t.integer :word_count
      t.float :final_score, precision: 5, scale: 2, null: false
      t.string :city
      t.string :region
      t.string :country
      t.string :remote_ip
      t.datetime :created_at
    end
  end
end
