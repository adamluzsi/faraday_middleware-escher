require 'socket'
require 'faraday/middleware/escher'
class Faraday::Middleware::Escher::Base < Faraday::Middleware

  def initialize(app,options={})

    super(app)
    @host = options[:host] || Socket.gethostname

    @escher_options = options[:options] || {}
    @escher_credential_scope = options[:credential_scope] || raise(ArgumentError,'missing escher credential scope!')

  end

end