require_relative '../spec_helper'
describe FaradayMiddleware::Escher::Base do

  let(:app){double('app')}

  let(:host){'localhost'}
  let(:api_key){'superKey'}
  let(:api_secret){'superSecret'}

  let(:options){
    {
        host: host,
        credential_scope: 'test/test/test'
    }
  }

  subject{ self.described_class.new(app,options) }

  before do
    allow(Socket).to receive(:gethostname).and_return(host)
  end

  describe '#initialize' do
    describe 'init take an options hash after app, and catch some of its value' do

      %W[ host ].each do |element|
        it "should save #{element} hast key's value under @#{element}" do
          expect(subject.instance_variable_get("@#{element}")).to eq options[element.to_sym]
        end
      end

      it 'should cache @app from the first argument' do
        expect(subject.instance_variable_get('@app')).to eq app
      end

    end

    it 'should child of the Faraday::Middleware class' do
      expect(subject).to be_a(Faraday::Middleware)
    end

  end

end