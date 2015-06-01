require_relative '../spec_helper'
describe FaradayMiddleware::Escher::RequestSigner do
  describe 'this is a faraday middleware witch instance will response to call method' do

    let(:api_key) { 'superKey' }
    let(:api_secret) { 'superSecret' }
    let(:host) { 'localhost' }

    let(:stubs) { Faraday::Adapter::Test::Stubs.new }

    subject do

      Faraday.new do |builder|

        builder.use FaradayMiddleware::Escher::RequestSigner,
                    api_key: api_key,
                    api_secret: api_secret,
                    host: host

        builder.adapter :test, stubs do |stub|
          stub.get('/ebi') { |env| [200, {}, 'shrimp'] }
        end

      end

    end

    let(:connection) do
      Faraday.new do |builder|
        builder.use FaradayMiddleware::Escher::RequestSigner,
                    api_key: api_key,
                    api_secret: api_secret,
                    host: host

        builder.use FaradayMiddleware::FollowRedirects
        builder.adapter Faraday.default_adapter
      end
    end

    let(:target_url) { "http://api-with-escher.example.com" }

    describe '#call' do

      it ''

      it "redirects" do

        # stubs.get('/uni') {[ 200, {}, 'urchin' ]}

        request_mock = stub_request(:get, target_url)

        puts request_mock.methods - Object.methods

        stub_request(:get, "http://facebook.com").to_return(
            :status => 302,
            :headers => {"Location" => "http://www.facebook.com/"})

        stub_request(:get, "http://www.facebook.com/").to_return(
            :status => 302,
            :headers => {"Location" => "https://www.facebook.com/"})

        stub_request(:get, "https://www.facebook.com/")

        response = connection.get "http://facebook.com"

        expect(response.env[:url].to_s).to eq("https://www.facebook.com/")

      end


    end

  end
end