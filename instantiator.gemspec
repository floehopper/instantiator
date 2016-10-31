# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "instantiator/version"

Gem::Specification.new do |s|
  s.name        = "instantiator"
  s.version     = Instantiator::VERSION
  s.authors     = ["James Mead"]
  s.email       = ["james@floehopper.org"]
  s.homepage    = ""
  s.summary     = %q{Instantiate an arbitrary Ruby class}

  s.rubyforge_project = "instantiator"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency("blankslate")

  if RUBY_VERSION < '1.9.3'
    s.add_development_dependency "rake", "~> 10.0"
  else
    s.add_development_dependency "rake"
  end
end
