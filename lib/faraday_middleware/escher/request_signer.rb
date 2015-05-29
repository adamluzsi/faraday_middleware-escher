class FaradayMiddleware::Escher::RequestSigner < FaradayMiddleware::Escher::Base

  def call(env)

    # p env.methods - Object.methods

    env.request_headers

    # @app.call(env).on_complete do |env|
    #   # do something with the response
    #   # env[:response] is now filled in
    # end

    @app.call(env)

  end

end