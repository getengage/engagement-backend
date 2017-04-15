class CreatePartitionedEventsRaw < ActiveRecord::Migration[4.2]
  def up
    1.upto(12) do |month|
      execute "CREATE TABLE events_raw_#{month} (CHECK (date_part('month', timestamp) = '#{month}')) INHERITS (events_raw);"
    end
  end
end
