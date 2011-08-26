# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "history/version"

Gem::Specification.new do |s|
  s.name        = "history"
  s.version     = History::VERSION
  s.authors     = ["Robert Bousquet"]
  s.email       = ["rbousquet@newleaders.com"]
  s.homepage    = "https://github.com/bousquet/history"
  s.summary     = "Preserve the history of a db record"
  s.description = "Currently offers soft deletion, and a default scope that excludes 'deleted' records"

  s.rubyforge_project = "history"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  s.add_runtime_dependency "activerecord"
  s.add_runtime_dependency "activesupport"
end
