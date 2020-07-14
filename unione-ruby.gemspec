# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'unione/version'

Gem::Specification.new do |spec|
  spec.add_dependency 'json', '~> 2.0'
  spec.add_dependency 'faraday', '~> 1.0'
  spec.add_dependency 'faraday_middleware', '~> 1.0'
  spec.add_dependency 'net-http-persistent', '~> 3.0'
  spec.add_dependency 'hashie', '~> 4.0'
  spec.add_dependency 'json-schema', '~> 2.0'
  spec.authors = ['UniOne developer']
  spec.description = 'Official UniOne Gem to Interact with UniOne Api in native Ruby'
  spec.email = 'devlib@unione.io'
  spec.files = `git ls-files -z`.split("\x0")
  spec.homepage = 'https://github.com/unione-repo/unione-ruby'
  spec.licenses = ['MIT']
  spec.name = 'unione-ruby'
  spec.require_paths = ['lib']
  spec.required_ruby_version = '>= 2.4'
  spec.summary = 'Official UniOne Gem'
  spec.version = UniOne::VERSION
end
