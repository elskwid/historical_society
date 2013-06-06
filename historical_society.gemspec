# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "historical_society/version"

Gem::Specification.new do |s|
  s.name        = "historical_society"
  s.version     = HistoricalSociety::VERSION
  s.authors     = ["Robert Bousquet"]
  s.email       = ["rbousquet@newleaders.com"]
  s.homepage    = "https://github.com/bousquet/historical_society"
  s.summary     = "Preserve the history of a db record"
  s.description = "Currently offers soft deletion, and a default scope that excludes 'deleted' records"

  s.rubyforge_project = "historical_society"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_development_dependency "rspec"
  s.add_development_dependency "rake"
  s.add_development_dependency "sqlite3"
  s.add_runtime_dependency "activerecord",  "~> 3.1"
  s.add_runtime_dependency "activesupport", "~> 3.1"
end
