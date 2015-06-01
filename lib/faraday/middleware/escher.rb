require 'escher'
require 'faraday'
require 'faraday/middleware'
module Faraday::Middleware::Escher
  require 'faraday/middleware/escher/base'
  require 'faraday/middleware/escher/request_signer'
  require 'faraday/middleware/escher/response_validator'
end