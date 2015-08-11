# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'test_simple/version'

Gem::Specification.new do |spec|
  spec.name          = "test_simple"
  spec.version       = TestSimple::VERSION
  spec.authors       = ["Colin Walker"]
  spec.email         = ["cjwalker@sfu.ca"]

  spec.summary       = %q{Very simple testing gem.}

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_dependency "colorize", "~> 0.7.7"
end
