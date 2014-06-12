# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mementus/version'

Gem::Specification.new do |spec|
  spec.name          = "mementus"
  spec.version       = Mementus::VERSION
  spec.authors       = ["maetl"]
  spec.email         = ["me@maetl.net"]
  spec.description   = %q{In-memory data model}
  spec.summary       = %q{In-memory data model}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "virtus"
  spec.add_runtime_dependency "axiom-memory-adapter"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
