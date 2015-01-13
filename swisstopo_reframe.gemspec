# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'swisstopo_reframe/version'

Gem::Specification.new do |spec|
  spec.name          = "swisstopo_reframe"
  spec.version       = SwisstopoReframe::VERSION
  spec.authors       = ["Alexander Rueedlinger"]
  spec.email         = ["a.rueedlinger@gmail.com"]
  spec.summary       = %q{A simple wrapper for the Swisstopo Reframe REST API to convert coordinate points into different coordinate systems.}
  spec.description   = %q{swisstopo_reframe is a wrapper for the wisstopo Reframe REST API to convert coordinate points into different coordinate systems.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 0"
end
