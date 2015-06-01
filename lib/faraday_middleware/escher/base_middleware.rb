require 'socket'
class FaradayMiddleware::Escher::BaseMiddleware < Faraday::Middleware

  def initialize(app,options={},&escher_keydb_constructor)

    super(app)
    @host = options[:host] || Socket.gethostname

    @escher_options = options[:options] || {}
    @escher_credential_scope = options[:credential_scope] || raise(ArgumentError,'missing escher credential scope!')
    @escher_keydb_constructor = escher_keydb_constructor || raise(ArgumentError,'missing escher constructor')

  end

end