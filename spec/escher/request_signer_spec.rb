require_relative '../spec_helper'
describe FaradayMiddleware::Escher::RequestSigner do
  describe 'this is a faraday middleware witch instance will response to call method' do

    let(:api_key){'superKey'}
    let(:api_secret){'superSecret'}
    let(:host){'localhost'}
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

    describe '#call' do

      it "redirects" do

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