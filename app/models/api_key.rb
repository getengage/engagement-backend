class ApiKey < ApplicationRecord
  include Reportable
  # acts_as_paranoid column: :expired_at

  has_one :client_api_key
  has_one :client, through: :client_api_key
  has_many :events_raw, class_name: "Event::EventsRaw", primary_key: :uuid
  has_many :events_processed, class_name: "Event::EventsProcessed", primary_key: :uuid

  trigger.after(:insert).declare("partition text; idx_api_key_id text; idx_source_url text") do
    <<-SQL
      partition := quote_ident('events_processed' || '_' || NEW.uuid);
      idx_api_key_id := quote_ident('idx_' || NEW.uuid || '_on_api_key_id');
      idx_source_url := quote_ident('idx_' || NEW.uuid || '_on_source_url');
      EXECUTE 'CREATE TABLE ' || partition || ' (check (api_key_id = ''' || NEW.uuid || ''')) INHERITS (events_processed);';
      EXECUTE 'CREATE INDEX ' || idx_api_key_id || ' ON ' || partition || ' (api_key_id);';
      EXECUTE 'CREATE INDEX ' || idx_source_url || ' ON ' || partition || ' (source_url);';
      RETURN NULL;
    SQL
  end

  def display_name
    name.titleize
  end
end
