# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'restcomm-ruby/version'

Gem::Specification.new do |spec|
  spec.name          = 'restcomm-ruby'
  spec.version       = Restcomm::VERSION
  spec.authors       = ['Charles Roufay']
  spec.email         = ['info@telestax.com']
  spec.summary       = 'A simple library for communicating with the Restcomm REST API, building RCML, and generating Restcomm Client Capability Tokens'
  spec.description   = 'A simple library for communicating with the Restcomm REST API, building RCML, and generating Restcomm Client Capability Tokens'
  spec.homepage      = 'http://github.com/restcomm/restcomm-ruby'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']
  spec.required_ruby_version = '>= 1.9.3'
  spec.extra_rdoc_files = ['README.md', 'LICENSE.md']
  spec.rdoc_options = ['--line-numbers', '--inline-source', '--title', 'restcomm-ruby', '--main', 'README.md']

  spec.add_dependency('multi_json', '>= 1.3.0')
  spec.add_dependency('builder', '>= 2.1.2')
  spec.add_dependency('jwt', '~> 1.0')
  spec.add_dependency('jruby-openssl') if RUBY_PLATFORM == 'java'
  # Workaround for RBX <= 2.2.1, should be fixed in next version
  spec.add_dependency('rubysl') if defined?(RUBY_ENGINE) && RUBY_ENGINE == 'rbx'

  spec.add_development_dependency 'bundler', '~> 1.5'
  spec.extra_rdoc_files = ['README.md', 'LICENSE.md']
  spec.rdoc_options = ['--line-numbers', '--inline-source', '--title', 'restcomm-ruby', '--main', 'README.md']
end
