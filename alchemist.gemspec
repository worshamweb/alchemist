# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "alchemist/version"

Gem::Specification.new do |s|
  s.name        = "alchemist"
  s.version     = Alchemist::VERSION
  s.authors     = ["Matthew Mongeau"]
  s.email       = ["matt@toastyapps.com"]
  s.homepage    = "https://github.com/halogenandtoast/alchemist"
  s.summary     = %q{Conversions... like you\'ve never seen them before!}
  s.description = %q{Conversions... like you\'ve never seen them before!!}

  s.rubyforge_project = "alchemist"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "rspec", "~> 2.6"

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
end
