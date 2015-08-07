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
    response.write 'OK'
    response.status = 200
    response.finish

  end

end

use Escher::RackMiddleware
run YourAwesomeApp.new
