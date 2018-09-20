# -*- encoding: utf-8 -*-
require File.expand_path('../lib/omniauth-jane/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["ShippingEasy"]
  gem.email         = ["dev@shippingeasy.com"]
  gem.description   = "OmniAuth Strategy for Jane"
  gem.summary       = "OmniAuth Strategy for Jane"
  gem.homepage      = "https://github.com/ShippingEasy/omniauth-jane"

  gem.files         = `git ls-files | grep -v example`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "omniauth-jane"
  gem.require_paths = ["lib"]
  gem.version       = OmniAuth::Jane::VERSION

  gem.add_dependency 'omniauth', '~> 1.0'
  gem.add_dependency 'omniauth-oauth2', '>= 1.5'
end
