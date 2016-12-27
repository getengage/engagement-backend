module Event
  class EventsRaw < ActiveRecord::Base
    belongs_to :api_key, primary_key: :uuid
    self.table_name = "events_raw"

    trigger.before(:insert).declare("partition text") do
      <<-SQL
        partition := quote_ident(TG_RELNAME || '_' || NEW.api_key_id);
        EXECUTE 'INSERT INTO ' || partition || ' SELECT(' || TG_RELNAME || ' ' || quote_literal(NEW) || ').* RETURNING id;';
        RETURN NULL;
      SQL
    end
  end
end
