# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "drunker"
require 'drunker/aggregator/phpmd/version'

Gem::Specification.new do |spec|
  spec.name          = "drunker-aggregator-phpmd"
  spec.version       = Drunker::Aggregator::Phpmd::VERSION
  spec.authors       = ["wata727"]
  spec.email         = ["watassbass@gmail.com"]

  spec.summary       = %q{PHPMD Aggregator for Drunker.}
  spec.description   = %q{PHPMD Aggregator for Drunker.}
  spec.homepage      = "https://github.com/wata727/drunker-aggregator-phpmd"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "timecop", "~> 0.8"

  spec.add_runtime_dependency "drunker", "~> 0.1"
end
