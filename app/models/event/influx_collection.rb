module Event
  class InfluxCollection < Hashie::Trash
    include Hashie::Extensions::Coercion
    property "name"
    property "tags"
    property "values"
    coerce_key :values, Array[OpenStruct]

    def self.query(query, *predicates)
      results = InfluxDB::Rails.client.query(query % predicates)
      new(results.first)
    end

    def self.influx_table
      name.tableize.gsub("/","_")
    end
  end
end
