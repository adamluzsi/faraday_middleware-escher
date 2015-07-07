lib_path = File.absolute_path(File.join(__dir__, '..', 'lib'))
$LOAD_PATH.unshift(p lib_path)

ENV['KEY_POOL'] = '[{"keyId":"EscherExample","secret":"TheBeginningOfABeautifulFriendship","acceptOnly":0}]'
ENV['ESCHEREXAMPLE_KEYID'] = 'EscherExample'

require 'faraday_middleware/escher'

conn = Faraday.new do |builder|

  builder.use FaradayMiddleware::Escher::RequestSigner, credential_scope: 'example/credential/scope' do
    {api_key_id: 'EscherExample', api_secret: 'TheBeginningOfABeautifulFriendship'}
  end

  builder.adapter :net_http

end

require 'json'

puts "\nResponse:",
     conn.get { |r|
       r.url('http://localhost:9292')
       r.body='{ "name": "Unagi" }'
       r.headers['X-Origin'] = JSON.generate(sender: 'cat',host: 'suite42')
     }.body.inspect