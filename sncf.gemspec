# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sncf/version'

Gem::Specification.new do |spec|
  spec.name          = "sncf"
  spec.version       = Sncf::VERSION
  spec.authors       = ["Rémi Delhaye"]
  spec.email         = ["remi@libertrip.com"]

  spec.summary       = %q{Open source ruby api client for SNCF Open Data API}
  spec.description   = %q{Open source ruby api client for SNCF Open Data API. Documentation available here: https://github.com/Libertrip/sncf }
  spec.homepage      = "https://github.com/Libertrip/sncf"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split("\n").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.required_ruby_version = '>= 2.0.0'

  spec.add_runtime_dependency "http", "~> 0.8.12"
  spec.add_runtime_dependency "oj", "~> 2.12"

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.3"
  spec.add_development_dependency "guard-rspec", "~> 4.5"
  spec.add_development_dependency "pry", "~> 0.10"
  spec.add_development_dependency "byebug", "~> 4.0"
  spec.add_development_dependency "pry-byebug", "~> 3.1"
end
