#backwardCompatibility
require 'faraday/middleware/escher'

begin
  require 'faraday_middleware'
rescue LoadError
end

unless defined?(FaradayMiddleware)
  module FaradayMiddleware
  end
end

FaradayMiddleware::Escher ||= ::Faraday::Middleware::Escher