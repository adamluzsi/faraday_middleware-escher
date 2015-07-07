#backwardCompatibility
begin
  require 'faraday_middleware'
rescue LoadError
end

unless defined?(FaradayMiddleware)
  module FaradayMiddleware
  end
end

require 'faraday/middleware/escher'
FaradayMiddleware::Escher ||= ::Faraday::Middleware::Escher