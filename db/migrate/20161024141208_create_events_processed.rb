class CreateEventsProcessed < ActiveRecord::Migration[4.2]
  def change
    create_table :events_processed do |t|
      t.uuid :uuid, default: 'uuid_generate_v4()'
      t.string :api_key_id, null: false
      t.string :source_url, null: false
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
      t.string :user_agent
      t.float :q1_time
      t.float :q2_time
      t.float :q3_time
      t.float :q4_time
      t.datetime :created_at
      t.datetime :timestamp
    end
  end
end
