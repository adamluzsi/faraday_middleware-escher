require 'faraday/middleware/escher'
class Faraday::Middleware::Escher::ResponseValidator < Faraday::Middleware::Escher::Base

  def initialize(app,options={},&keydb_as_block)

    super(app,options)

    keydb_constructor = keydb_as_block || options[:keydb_constructor] || options[:keydb]
    raise('Key DB constuctor must be a lambda/block') unless keydb_constructor.is_a?(Proc)
    @escher_active_key_constructor = keydb_constructor

  end

  def call(request_env)
    @app.call(request_env).on_complete do |env_on_response|
      authenticate_env!(env_on_response)
    end
  end

  protected

  def authenticate_env!(env_on_response)

    escher = ::Escher::Auth.new(@escher_credential_scope, @escher_options)

    url_path = env_on_response[:url].path
    url_path = '/' if url_path.empty?

    escher_hash_env = {
        uri: url_path,
        method: env_on_response[:method].to_s.upcase,
        headers: env_on_response[:response_headers].map{|k,v| [k,v] }
    }

    escher_hash_env[:body] = env_on_response[:body] if env_on_response[:body]
    escher.authenticate(escher_hash_env,@escher_active_key_constructor.call)

  end

end