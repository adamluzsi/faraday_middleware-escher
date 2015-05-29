class FaradayMiddleware::Escher::BaseMiddleware < Faraday::Middleware

  def initialize(app,options={})

    super(app)

    @api_key = options[:api_key] || raise(ArgumentError.new('missing escher api key'))
    @api_secret = options[:api_secret] || raise(ArgumentError.new('missing escher api secret'))
    @host = options[:host] || raise(ArgumentError.new('missing host'))

  end

end