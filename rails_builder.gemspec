$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "rails_builder/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "rails_builder"
  s.version     = RailsBuilder::VERSION
  s.authors     = ["Jason Kadrmas"]
  s.email       = ["blackjk@gmail.com"]
  s.homepage    = "http://github.com"
  s.summary     = "Interactive building tool for ruby on rails."
  s.description = "Interactive building tool for ruby on rails."

  s.files = Dir["{app,config,db,lib,vendor}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 3.2.15"
  # s.add_dependency "jquery-rails"
  s.add_dependency "ejs", "~> 1.1.1"
  s.add_dependency "meta_request"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "binding_of_caller"
  s.add_development_dependency "better_errors"
end
