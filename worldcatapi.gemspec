# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'worldcatapi/version'

Gem::Specification.new do |spec|
  spec.name          = "worldcatapi"
  spec.version       = Worldcatapi::VERSION
  spec.authors       = ["Taras Danylak"]
  spec.email         = ["taras@danylak.com"]
  spec.description   = %q{Ruby API to access WorldCat Open Search webservice}
  spec.summary       = %q{Ruby API to access WorldCat Open Search webserbice}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
