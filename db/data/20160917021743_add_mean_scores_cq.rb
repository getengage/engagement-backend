require 'influxdb'

class AddMeanScoresCq < ActiveRecord::Migration
  def self.up
    influxdb = InfluxDB::Client.new host: "localhost"
    database = "engagement_#{Rails.env}"
    name = "mean_scores_1d"
    query = "SELECT MEAN(score) INTO mean_scores_1d FROM event_scores GROUP BY source_url, time(1d)"
    influxdb.create_continuous_query(name, database, query)
  end

  def self.down
    influxdb = InfluxDB::Client.new host: "localhost"
    database = "engagement_#{Rails.env}"
    name = "mean_scores_1d"
    influxdb.delete_continuous_query(name, database)
  end
end
