# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'faraday_middleware/escher/version'

Gem::Specification.new do |spec|
  spec.name          = "faraday_middleware-escher"
  spec.version       = FaradayMiddleware::Escher::VERSION
  spec.authors       = ["Adam Luzsi"]
  spec.email         = ["adamluzsi@gmail.com"]
  spec.summary       = %q{escher sign and validation for faraday http rest client}
  spec.description   = %q{WIP!!! escher sign and validation for faraday http rest client}
  spec.homepage      = 'https://github.com/adamluzsi/faraday_middleware-escher'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency 'bundler', "~> 1.6"
  spec.add_development_dependency 'rake'
end
