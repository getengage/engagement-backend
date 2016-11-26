module InfluxQuery
  include ActiveModel::Naming

  def collection(params={})
    params["values"].map{ |values|
      new(values)
    } if params
  end

  def query(query, *predicates)
    results = InfluxDB::Rails.client.query(query % predicates)
    collection(results.first)
  end

  def influx_table
    model_name.route_key.tableize
  end

  def influx_db
    InfluxDB::Rails.configuration.influxdb_database
  end
end
