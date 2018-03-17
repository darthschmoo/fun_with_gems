# encoding: utf-8

require_relative 'lib/fun_with_gems'
require "byebug"
self.extend( FunWith::Gems::Rakefile )

rakefile_setup( FunWith::Gems )



gem_specification do |gem|
  # gem is a Gem::Specification... see http://guides.rubygems.org/specification-reference/ for more options
  gem.name        = "fun_with_gems"
  gem.homepage    = "http://github.com/darthschmoo/fun_with_gems"
  gem.license     = "MIT"
  gem.summary     = "Dependency for most of my FunWith:: gems.  Not much use standalone."
  gem.description = "Dependency for FunWith gems, simplifies the setup of new gems, installing version data, root filepath, and default requirements."
  gem.email       = "keeputahweird@gmail.com"
  gem.authors     = ["Bryce Anderson"]
  # dependencies defined in Gemfile
  
  add_specification_files( gem, :default )
end

setup_gem_boilerplate
