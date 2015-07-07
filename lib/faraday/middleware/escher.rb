require 'escher'
require 'faraday'
require 'faraday/middleware'
require 'faraday_middleware/escher'
module Faraday::Middleware::Escher
  require 'faraday/middleware/escher/base'
  require 'faraday/middleware/escher/request_signer'
  require 'faraday/middleware/escher/response_validator'
end