gem_root_dir = File.join(File.dirname(__FILE__),'..')
$LOAD_PATH.unshift(File.join(gem_root_dir,'lib'))


require 'rspec'
require 'webmock/rspec'
require 'faraday_middleware/escher'

module EnvCompatibility
  def faraday_env(env)
    if defined?(Faraday::Env)
      Faraday::Env.from(env)
    else
      env
    end
  end
end

module ResponseMiddlewareExampleGroup
  def self.included(base)
    base.let(:options) { Hash.new }
    base.let(:headers) { Hash.new }
    base.let(:middleware) {
      described_class.new(lambda {|env|
                            Faraday::Response.new(env)
                          }, options)
    }
  end

  def process(body, content_type = nil, options = {})
    env = {
        :body => body, :request => options,
        :request_headers => Faraday::Utils::Headers.new,
        :response_headers => Faraday::Utils::Headers.new(headers)
    }
    env[:response_headers]['content-type'] = content_type if content_type
    yield(env) if block_given?
    middleware.call(faraday_env(env))
  end
end

RSpec.configure do |config|
  config.include EnvCompatibility
  config.include ResponseMiddlewareExampleGroup, :type => :response
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

class ExpectsMiddleware < Faraday::Middleware

  def initialize(app,request_expectations:nil,response_expectations:nil)
    super(app)
    @request_expectations = request_expectations
    @response_expectations = response_expectations
  end

  def call(env)

    @request_expectations.call(env) if @request_expectations.respond_to?(:call)

    @app.call(env).on_complete do |env|
      @response_expectations.call(env) if @response_expectations.respond_to?(:call)
    end

  end

end