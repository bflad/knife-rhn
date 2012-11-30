# -*- encoding: utf-8 -*-
require File.expand_path('../lib/knife-rhn/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Brian Flad"]
  gem.email         = ["bflad@wharton.upenn.edu"]
  gem.description   = %q{A knife plugin for managing RHN.}
  gem.summary       = gem.summary
  gem.homepage      = "https://github.com/bflad/knife-rhn"

  gem.add_runtime_dependency "rhn_satellite"

  gem.files         = `git ls-files`.split($\)
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "knife-rhn"
  gem.require_paths = ["lib"]
  gem.version       = Knife::RHN::VERSION
end
