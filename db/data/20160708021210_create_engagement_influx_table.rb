require 'influxdb'

class CreateEngagementInfluxTable < ActiveRecord::Migration
  def self.up
    influxdb = InfluxDB::Client.new host: "localhost"
    influxdb.create_database("engagement_#{Rails.env}")
  end

  def self.down
    influxdb = InfluxDB::Client.new host: "localhost"
    influxdb.delete_database("engagement_#{Rails.env}")
  end
end
