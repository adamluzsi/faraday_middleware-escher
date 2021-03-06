require_relative '../spec_helper'
describe Faraday::Middleware::Escher::RequestSigner do
  describe 'this is a faraday middleware witch instance will response to call method' do

    let(:key_db){{api_key_id: 'EscherExample', api_secret: 'TheBeginningOfABeautifulFriendship'}}

    let(:api_key) { 'superKey' }
    let(:api_secret) { 'superSecret' }
    let(:host) { 'localhost' }

    let(:target_url) { "http://api-with-escher.example.com" }
    let(:stubs) { Faraday::Adapter::Test::Stubs.new }

    let(:request_expectations){ -> env { @request_env = env } }
    let(:response_expectations){ -> env { @response_env = env } }

    before do
      @request_env = nil
      @response_env = nil
    end

    subject do

      Faraday.new do |builder|


        builder.use Faraday::Middleware::Escher::RequestSigner, credential_scope: 'example/credential/scope'  do
          {api_key_id: 'EscherExample', api_secret: 'TheBeginningOfABeautifulFriendship'}
        end

        builder.use ExpectsMiddleware, request_expectations: request_expectations
        builder.use ExpectsMiddleware, response_expectations: response_expectations

        builder.adapter :test, stubs do |stub|
          stub.get(target_url) { |env| [200, {}, 'shrimp'] }
        end

      end

    end


    describe '#call' do

      it 'should insert escher request headers for the call' do

        expect( subject.get(target_url).status ).to eq 200
        expect( @request_env[:request_headers]["X-Escher-Auth"].nil? ).to eq false
        expect( @request_env[:request_headers]["X-Escher-Date"].nil? ).to eq false

      end

    end

  end
end