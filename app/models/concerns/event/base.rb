module Event
  module Base
    extend ActiveSupport::Concern
    included do
      belongs_to :api_key, primary_key: :uuid
      self.table_name = self.table_name.singularize

      trigger.before(:insert).declare("partition text") do
        <<-SQL
          partition := quote_ident(TG_RELNAME || '_' || #{partition_key});
          EXECUTE 'INSERT INTO ' || partition || ' SELECT(' || TG_RELNAME || ' ' || quote_literal(NEW) || ').* RETURNING id;';
          RETURN NULL;
        SQL
      end
    end
  end
end
