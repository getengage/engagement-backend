require 'influxdb'

class AddReferralsCq < ActiveRecord::Migration
  def self.up
    database = "engagement_#{Rails.env}"
    name = "referrals_1d"
    query = "SELECT COUNT(DISTINCT(referrer)) INTO referrals_1d FROM event_scores WHERE time > now() - 30d GROUP BY source_url, time(1d)"
    InfluxDB::Rails.client.create_continuous_query(name, database, query)
  end

  def self.down
    database = "engagement_#{Rails.env}"
    name = "referrals_1d"
    InfluxDB::Rails.client.delete_continuous_query(name, database)
  end
end
