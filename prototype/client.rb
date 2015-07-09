$LOAD_PATH.unshift(File.absolute_path(File.join(__dir__, '..', 'lib')))

require_relative 'credentials'

require 'faraday_middleware/escher'

conn = Faraday.new do |builder|

  builder.use FaradayMiddleware::Escher::RequestSigner,
              credential_scope: CredentialScope,
              options: AuthOptions,
              active_key: -> { Escher::Keypool.new.get_active_key('EscherExample') }

  # builder.use FaradayMiddleware::Escher::ResponseValidator,
  #             credential_scope: CredentialScope,
  #             options: AuthOptions,
  #             keydb_constructor: -> { Escher::Keypool.new.get_key_db }

  builder.adapter :net_http


end

require 'json'

puts "\nResponse:",
     conn.get { |r|
       r.url('http://localhost:9292')
       r.body='{ "name": "Unagi" }'
       r.headers['X-Origin'] = JSON.generate(sender: 'cat', host: 'suite42')
       r.params['kutya1']= 'cica1'
       r.params['kutya2']= 'cica2'
     }.body.inspect
