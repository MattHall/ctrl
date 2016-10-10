# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ctrl/version'

Gem::Specification.new do |spec|
  spec.name          = "infra-ctrl"
  spec.license       = "MIT"
  spec.version       = Ctrl::VERSION
  spec.authors       = ["Matt Hall"]
  spec.email         = ["matt@codebeef.com"]

  spec.summary       = "Control infra"
  spec.description   = "Simple way to ls / ssh into vpns"
  spec.homepage      = "https://github.com/MattHall/ctrl"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "bin"
  spec.executables   = ["ctrl"]
  spec.require_paths = ["lib"]

  spec.add_dependency "virtus", '~> 1.0'
  spec.add_dependency('methadone', '~> 1.9')
  spec.add_dependency('aws-sdk', '~> 2')

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency('aruba', "~> 0.14")
  spec.add_development_dependency('pry', "0.14")
end
