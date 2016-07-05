class CreateEvents < CassandraMigrations::Migration
  def up
    create_table :events_by_source_url, primary_keys: [:api_key, :source_url] do |t|
      t.string :api_key
      t.string :session_id
      t.string :uuid
      t.string :referrer_url
      t.integer :x_pos
      t.integer :y_pos
      t.boolean :page_visible
      t.string :source_url
      t.timestamp :timestamp
      t.timestamp :date
      t.integer :time_on_page
      t.boolean :content_in_viewport
    end

    create_table :events_by_session_id, primary_keys: [:api_key, :session_id] do |t|
      t.string :api_key
      t.string :session_id
      t.string :uuid
      t.string :referrer_url
      t.integer :x_pos
      t.integer :y_pos
      t.boolean :page_visible
      t.string :source_url
      t.timestamp :timestamp
      t.timestamp :date
      t.integer :time_on_page
      t.boolean :content_in_viewport
    end

    create_table :events_by_uuid, primary_keys: [:api_key, :uuid] do |t|
      t.string :api_key
      t.string :session_id
      t.string :uuid
      t.string :referrer_url
      t.integer :x_pos
      t.integer :y_pos
      t.boolean :page_visible
      t.string :source_url
      t.timestamp :timestamp
      t.timestamp :date
      t.integer :time_on_page
      t.boolean :content_in_viewport
    end

  end

  def down
    drop_table :events_by_uuid
    drop_table :events_by_session_id
    drop_table :events_by_source_url
  end
end
