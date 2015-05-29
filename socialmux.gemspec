# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'socialmux/version'

Gem::Specification.new do |spec|
  spec.name          = "socialmux"
  spec.version       = Socialmux::VERSION
  spec.authors       = ["Stefano Verna"]
  spec.email         = ["stefano.verna@welaika.com"]
  spec.description   = %q{Socialmux implements a strategy to add multiple social providers to the same user. It's meant to be used togheter with OmniAuth.}
  spec.summary       = %q{Socialmux implements a strategy to add multiple social providers to the same user. It's meant to be used togheter with OmniAuth.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'coveralls'
  spec.add_development_dependency 'mocha'
  spec.add_development_dependency 'bourne'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rspec-its'

  spec.add_dependency 'activesupport'
  spec.add_dependency 'hashie'
end

