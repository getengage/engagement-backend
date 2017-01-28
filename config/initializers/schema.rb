require 'active_record'
ActiveRecord::SchemaDumper.ignore_tables << /events_processed_/
