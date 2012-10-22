# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'formkeeper/japanese/version'

Gem::Specification.new do |gem|
  gem.name          = "formkeeper-japanese"
  gem.version       = FormKeeper::Japanese::VERSION
  gem.authors       = ["lyokato"]
  gem.email         = ["lyo.kato@gmail.com"]
  gem.description   = %q{formkeeper's plugin for japanese specific filters and validators}
  gem.summary       = %q{This module provides you japanese specific filters and validators}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end

