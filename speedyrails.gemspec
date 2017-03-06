# coding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'speedyrails/version'

Gem::Specification.new do |spec|
  spec.name          = 'speedyrails'
  spec.version       = Speedyrails::VERSION
  spec.authors       = ['Dylan Arbour']
  spec.email         = ['dylan@speedyrails.com']

  spec.summary       = 'Ruby bindings for Speedyrails API'
  spec.homepage      = 'https://github.com/speedyrails/speedyrails-ruby'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 2.0.0'

  spec.add_dependency 'faraday', '~> 0.9', '>= 0.9.1'
  spec.add_dependency 'kartograph', '~> 0.2'
  spec.add_dependency 'resource_kit', '~> 0.1'
  spec.add_dependency 'virtus', '~> 1.0'

  spec.add_development_dependency 'bundler', '~> 1.13', '>= 1.13.0'
  spec.add_development_dependency 'minitest', '~> 5.0'
  spec.add_development_dependency 'pry', '~> 0.10'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'webmock', '~> 2'
end
