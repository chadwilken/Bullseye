# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bullseye/version'

Gem::Specification.new do |spec|
  spec.name          = "bullseye"
  spec.version       = Bullseye::VERSION
  spec.authors       = ["Chad Wilken"]
  spec.email         = ["chad.wilken@gmail.com"]
  spec.summary       = "XCode Project and Directory checker to ensure all files are included in a specific app Target's Bundle Resources and Compiled Sources"
  spec.description   = 
  spec.homepage      = "https://github.com/chadwilken/Bullseye"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = ["bullseye"]
  # spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "xcodeproj"
end
