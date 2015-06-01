# FaradayMiddleware::Escher

escher sign and validation for faraday http rest client

## Installation

Add this line to your application's Gemfile:

    gem 'faraday_middleware-escher'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install faraday_middleware-escher

## Usage

### for sign requests 

The FaradayMiddleware::Escher::RequestSigner will help you sign your requests before sending them

```ruby

 
    require 'faraday_middleware/escher'
    conn = Faraday.new do |builder|
    
      builder.use FaradayMiddleware::Escher::RequestSigner, credential_scope: 'example/credential/scope'  do
                    {api_key_id: 'EscherExample', api_secret: 'TheBeginningOfABeautifulFriendship'}
                  end
    
      builder.adapter  :net_http
    
    end

```

TODO: Write usage instructions here

## Contributing

1. Fork it ( https://github.com/[my-github-username]/faraday_middleware-escher/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
