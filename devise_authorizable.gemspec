$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "devise_authorizable/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "devise_authorizable"
  s.version     = DeviseAuthorizable::VERSION
  s.authors     = ["Kai Schneider"]
  s.email       = ["schneikai@gmail.com"]
  s.homepage    = "https://github.com/schneikai/devise_authorizable"
  s.summary     = "Adds user roles and authorization to devise."
  s.description = "Description of DeviseAuthorizable."

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.0"
  s.add_dependency "devise", "~> 3.0"
  s.add_dependency "cancan", ">= 1.6.10", "< 2"

  s.add_development_dependency "jquery-rails"
  s.add_development_dependency "sqlite3"
end
