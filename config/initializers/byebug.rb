require 'byebug/core'

if Rails.env.development?
  Byebug.start_server 'localhost', ENV.fetch("BYEBUG_SERVER_PORT", 1055).to_i
end
