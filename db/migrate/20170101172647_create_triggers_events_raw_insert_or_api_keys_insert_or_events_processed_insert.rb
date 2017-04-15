# This migration was auto-generated via `rake db:generate_trigger_migration'.
# While you can edit this file, any changes you make to the definitions here
# will be undone by the next auto-generated trigger migration.

class CreateTriggersEventsRawInsertOrApiKeysInsertOrEventsProcessedInsert < ActiveRecord::Migration[4.2]
  def up
    create_trigger("events_raw_before_insert_row_tr", :generated => true, :compatibility => 1).
        on("events_raw").
        before(:insert).
        declare("partition text") do
      <<-SQL_ACTIONS
          partition := quote_ident(TG_RELNAME || '_' || date_part('month', NEW.timestamp));
          IF NEW.created_at IS NULL THEN
              NEW.created_at := NOW();
          END IF;
          EXECUTE 'INSERT INTO ' || partition || ' SELECT(' || TG_RELNAME || ' ' || quote_literal(NEW) || ').* RETURNING id;';
          RETURN NULL;
      SQL_ACTIONS
    end

    create_trigger("api_keys_after_insert_row_tr", :generated => true, :compatibility => 1).
        on("api_keys").
        after(:insert).
        declare("partition text; idx_api_key_id text; idx_source_url text") do
      <<-SQL_ACTIONS
      partition := quote_ident('events_processed' || '_' || NEW.uuid);
      idx_api_key_id := quote_ident('idx_' || NEW.uuid || '_on_api_key_id');
      idx_source_url := quote_ident('idx_' || NEW.uuid || '_on_source_url');
      EXECUTE 'CREATE TABLE ' || partition || ' (check (api_key_id = ''' || NEW.uuid || ''')) INHERITS (events_processed);';
      EXECUTE 'CREATE INDEX ' || idx_api_key_id || ' ON ' || partition || ' (api_key_id);';
      EXECUTE 'CREATE INDEX ' || idx_source_url || ' ON ' || partition || ' (source_url);';
      RETURN NULL;
      SQL_ACTIONS
    end

    create_trigger("events_processed_before_insert_row_tr", :generated => true, :compatibility => 1).
        on("events_processed").
        before(:insert).
        declare("partition text") do
      <<-SQL_ACTIONS
          partition := quote_ident(TG_RELNAME || '_' || NEW.api_key_id);
          IF NEW.created_at IS NULL THEN
              NEW.created_at := NOW();
          END IF;
          EXECUTE 'INSERT INTO ' || partition || ' SELECT(' || TG_RELNAME || ' ' || quote_literal(NEW) || ').* RETURNING id;';
          RETURN NULL;
      SQL_ACTIONS
    end
  end

  def down
    drop_trigger("events_raw_before_insert_row_tr", "events_raw", :generated => true)

    drop_trigger("api_keys_after_insert_row_tr", "api_keys", :generated => true)

    drop_trigger("events_processed_before_insert_row_tr", "events_processed", :generated => true)
  end
end
