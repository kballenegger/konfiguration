# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'konfiguration/version'

Gem::Specification.new do |spec|
  spec.name          = 'konfiguration'
  spec.version       = Konfiguration::VERSION
  spec.authors       = ['Kenneth Ballenegger']
  spec.email         = ['kenneth@ballenegger.com']
  spec.summary       = %q{Konfiguration makes it easy to load YAML-formatted configuration files.}
  spec.description   = %q{Konfiguration makes it easy to load YAML-formatted configuration files.}
  spec.homepage      = 'https://github.com/kballenegger/konfiguration'

  spec.files         = `git ls-files -z`.split('\x0')
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'rake'
end
