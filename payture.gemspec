# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'payture/version'

Gem::Specification.new do |spec|
  spec.name          = "payture"
  spec.version       = Payture::VERSION
  spec.authors       = ["Igor Davydov"]
  spec.email         = ["iskiche@gmail.com"]
  spec.summary       = %q{Payture api ruby gem}
  spec.description   = %q{Optional.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5"
  spec.add_development_dependency "webmock"
  spec.add_development_dependency "minitest-vcr"
  spec.add_development_dependency "vcr"
  spec.add_dependency "faraday"
  spec.add_dependency "faraday_middleware"
  spec.add_dependency "multi_xml"
  spec.add_dependency "hashie"
end
