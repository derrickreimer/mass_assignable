# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |gem|
  gem.name          = "mass_assignable"
  gem.version       = "1.0.0"
  gem.authors       = ["Derrick Reimer"]
  gem.email         = ["derrickreimer@gmail.com"]
  gem.description   = %q{Add Rails-like mass assignment to any Ruby object}
  gem.summary       = %q{MassAssignable provides mass assignment functionality to any Ruby object.}
  gem.homepage      = "https://github.com/djreimer/mass_assignable"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  
  gem.add_development_dependency "shoulda-context"
end
