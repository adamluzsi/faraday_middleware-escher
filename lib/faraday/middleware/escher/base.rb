require 'faraday/middleware/escher'
class Faraday::Middleware::Escher::Base < Faraday::Middleware

  def initialize(app,options={})

    super(app)
    @host = options[:host]

    @escher_options = options[:options] || {}
    @escher_credential_scope = options[:credential_scope] || raise(ArgumentError,'missing escher credential scope!')

  end

end