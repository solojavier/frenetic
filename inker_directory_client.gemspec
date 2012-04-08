# -*- encoding: utf-8 -*-
require File.expand_path('../lib/inker_directory_client/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Derek Lindahl"]
  gem.email         = ["dlindahl@customink.com"]
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = ""

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "inker_directory_client"
  gem.require_paths = ["lib"]
  gem.version       = InkerDirectoryClient::VERSION

  gem.add_dependency             'faraday',       '~> 0.7.6'

  gem.add_development_dependency 'guard-spork',   '~> 0.6.0'
  gem.add_development_dependency 'guard-rspec',   '~> 0.7.0'
  gem.add_development_dependency 'rspec',         '~> 2.9.0'
  gem.add_development_dependency 'bourne',        '~> 1.1.2'
end