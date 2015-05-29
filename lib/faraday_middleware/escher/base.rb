class FaradayMiddleware::Escher::Base < Faraday::Middleware

  def initialize(app)
    super(app)
  end

end