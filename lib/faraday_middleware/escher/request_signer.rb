class FaradayMiddleware::Escher::RequestSigner < FaradayMiddleware::Escher::BaseMiddleware

  def call(env)

    escher = Escher::Auth.new(@escher_credential_scope, @escher_options)

    uri_path = env[:url].path
    endpoint = uri_path.empty? ? '/' : uri_path

    request_data = {
        uri: endpoint,
        method: env[:method].to_s.upcase,
        headers: env[:request_headers].map{|k,v| [k,v] }.push(['host',@host])
    }

    request_data[:body]= env[:body] unless env[:body].nil?

    escher.sign!(
        request_data,
        @escher_keydb_constructor.call,
        request_data[:headers].map{|ary| ary[0] }
    )

    env[:request_headers].merge!(request_data[:headers])

    return @app.call(env)

  end

end