require 'faraday/middleware/escher'
class Faraday::Middleware::Escher::RequestSigner < Faraday::Middleware::Escher::Base

  def initialize(app,options={},&active_key)

    super(app,options)

    active_key_cons = active_key || options[:active_key] || options[:key]
    raise('Escher active key constructor must be a lambda/block') unless active_key_cons.is_a?(Proc)
    @escher_active_key_constructor = active_key_cons

  end

  def call(env)

    escher = ::Escher::Auth.new(@escher_credential_scope, @escher_options)

    uri_path = env[:url].path
    endpoint = uri_path.empty? ? '/' : uri_path
    endpoint_with_query = [endpoint,env[:url].query].join('?')

    request_data = {
        uri: endpoint_with_query,
        method: env[:method].to_s.upcase,
        headers: env[:request_headers].map{|k,v| [k,v] }.push(['host',@host])
    }

    request_data[:body]= env[:body] unless env[:body].nil?

    escher.sign!(
        request_data,
        @escher_active_key_constructor.call,
        request_data[:headers].map{|ary| ary[0] }
    )

    env[:request_headers].merge!(request_data[:headers])

    return @app.call(env)

  end

end