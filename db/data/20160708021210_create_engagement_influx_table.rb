require 'influxdb'

class CreateEngagementInfluxTable < ActiveRecord::Migration
  def self.up
    InfluxDB::Rails.client.create_database("engagement_#{Rails.env}")
  end

  def self.down
    InfluxDB::Rails.client.delete_database("engagement_#{Rails.env}")
  end
end
