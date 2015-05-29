class FaradayMiddleware::Escher::RequestSigner < FaradayMiddleware::Escher::BaseMiddleware

  def call(env)

    # p env.methods - Object.methods

    env.request_headers

    # env[:request_headers]


    response = @app.call(env)

    # response.on_complete do |env|
    #   # do something with the response
    #   # env[:response] is now filled in
    # end

    return response

  end

  protected



end