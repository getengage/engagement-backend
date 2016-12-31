class CreatePartitionedEventsRaw < ActiveRecord::Migration
  def up
    1.upto(12) do |month|
      execute "CREATE TABLE events_raw_#{month} (CHECK (date_part('month', created_at) = '#{month}')) INHERITS (events_raw);"
      add_index "events_raw_#{month}", :api_key_id
    end
  end
end
