if ENV['RACK_ENV'] == 'production'
  require 'config/production.rb'

  Bundler.require(:default)
  ADDRESS = "83.167.232.160"
  STATIC_PORT = 80
  WEBSOCKET_PORT = 90
else
  Bundler.require(:default, :development)
  ADDRESS = "0.0.0.0"
  STATIC_PORT = 3000
  WEBSOCKET_PORT = 8080
end
