InfluxDB::Rails.configure do |config|
  config.influxdb_database = "engagement_#{Rails.env}"
  config.influxdb_username = "root"
  config.influxdb_password = "root"
  config.influxdb_hosts    = [Rails.env.production? ? "influxdb" : "development"]
  config.influxdb_port     = 8086
  config.logger            = Logger.new(STDERR)
  config.logger.level      = Logger::FATAL

  # config.series_name_for_controller_runtimes = "rails.controller"
  # config.series_name_for_view_runtimes       = "rails.view"
  # config.series_name_for_db_runtimes         = "rails.db"
end
