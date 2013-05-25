# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dotman/version'

Gem::Specification.new do |spec|
  spec.name          = "dotman"
  spec.version       = Dotman::VERSION
  spec.authors       = ["Tim"]
  spec.email         = ["timbinous@gmail.com"]
  spec.description   = %q{Dotfiles Manager}
  spec.summary       = %q{Use this utility to manage your dotfiles and others who may use the same login user as yourself}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
