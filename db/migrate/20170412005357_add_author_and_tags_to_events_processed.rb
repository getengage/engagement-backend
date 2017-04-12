class AddAuthorAndTagsToEventsProcessed < ActiveRecord::Migration
  def change
    add_column :events_raw, :tags, :string
    add_column :events_processed, :tags, :text, array: true, default: []
    add_index :events_processed, :tags, using: :gin
  end
end
