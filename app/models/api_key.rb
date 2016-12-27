class ApiKey < ActiveRecord::Base
  include Reportable
  acts_as_paranoid column: :expired_at

  has_one :client_api_key
  has_one :client, through: :client_api_key
  has_many :events_raw, class_name: "Event::EventsRaw"
  has_many :events_processed, class_name: "Event::EventsProcessed"

  trigger.after(:insert).declare("partition text") do
    <<-SQL
      partition := quote_ident('events_raw' || '_' || NEW.uuid);
      EXECUTE 'CREATE TABLE ' || partition || ' (check (api_key_id = ''' || NEW.uuid || ''')) INHERITS (events_raw);';
      RETURN NULL;
    SQL
  end

  def display_name
    name.titleize
  end
end
