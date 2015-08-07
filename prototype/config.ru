require_relative 'credentials'

require 'rack'
require 'escher/rack_middleware'
Escher::RackMiddleware.config do |c|
  c.add_escher_authenticator { Escher::Auth.new(CredentialScope, AuthOptions) }
  c.add_credential_updater { Escher::Keypool.new.get_key_db }
end

require 'socket'
class YourAwesomeApp

  def call(env)

    response = Rack::Response.new
    response_payload = 'OK'

    escher = ::Escher::Auth.new(CredentialScope, AuthOptions)

    request_data = {

        uri: '/',
        method: 'GET',
        headers: [['host',Socket.gethostname]],
        body: response_payload

    }

    escher.sign!(
        request_data,
        Escher::Keypool.new.get_active_key( env['escher.request.api_key_id'] ),
        response.headers.map { |k, _| k }
    )

    request_data[:headers].each do |key,value|
      response.headers[key]=value
    end

    response.headers['kutya']='cica'

    response.write response_payload
    response.status = 200
    response.finish

  end

end

use Escher::RackMiddleware
run YourAwesomeApp.new
