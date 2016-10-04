require 'influxdb'

class AddMeanScoresCq < ActiveRecord::Migration
  def self.up
    database = "engagement_#{Rails.env}"
    name = "mean_scores_1d"
    query = "SELECT MEAN(score) INTO mean_scores_1d FROM event_scores GROUP BY source_url, time(1d)"
    InfluxDB::Rails.client.create_continuous_query(name, database, query)
  end

  def self.down
    database = "engagement_#{Rails.env}"
    name = "mean_scores_1d"
    InfluxDB::Rails.client.delete_continuous_query(name, database)
  end
end
