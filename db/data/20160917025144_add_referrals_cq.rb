require 'influxdb'

class AddReferralsCq < ActiveRecord::Migration
  def self.up
    influxdb = InfluxDB::Client.new host: "localhost"
    database = "engagement_#{Rails.env}"
    name = "referrals_1d"
    query = "SELECT COUNT(DISTINCT(referrer)) INTO referrals_1d FROM event_scores GROUP BY source_url, time(1d)"
    influxdb.create_continuous_query(name, database, query)
  end

  def self.down
    influxdb = InfluxDB::Client.new host: "localhost"
    database = "engagement_#{Rails.env}"
    name = "referrals_1d"
    influxdb.delete_continuous_query(name, database)
  end
end
