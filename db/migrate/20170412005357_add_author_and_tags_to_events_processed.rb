class AddAuthorAndTagsToEventsProcessed < ActiveRecord::Migration[4.2]
  def change
    add_column :events_raw, :tags, :string
    add_column :events_processed, :tags, :string

    reversible do |dir|
      dir.up do
        execute "CREATE INDEX events_processed_gin_tags ON events_processed
          USING GIN(to_tsvector('english', tags))"
      end

      dir.down do
        execute "DROP INDEX events_processed_gin_tags"
      end
    end
  end
end
