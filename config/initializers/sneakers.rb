require 'sneakers'
require 'sneakers/handlers/maxretry'

config_file = File.read(::Rails.root.to_s + '/config/sneakers.yml')
config = YAML.load(config_file)[::Rails.env].symbolize_keys
  .merge(handler: Sneakers::Handlers::Maxretry)
Sneakers.configure(config)
Sneakers.logger.level = Logger::INFO
