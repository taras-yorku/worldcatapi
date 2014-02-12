# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'worldcatapi/version'

Gem::Specification.new do |spec|
  spec.name          = "worldcatapi"
  spec.version       = WORLDCATAPI::VERSION
  spec.authors       = ["Taras Danylak", "Terry Reese"]
  spec.email         = ["taras@danylak.com", 'terry.reese@oregonstate.edu']
  spec.description   = %q{Ruby API to access WorldCat Open Search webservice. Based on WCAPI Gem.}
  spec.summary       = %q{Ruby API to access WorldCat Open Search webserbice. Based on WCAPI Gem.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]
  
  
  spec.add_runtime_dependency "nokogiri", "~>1.5.7"
  
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
