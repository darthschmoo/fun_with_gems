# encoding: utf-8
require_relative 'lib/fun_with_gems'

FunWith::Gems::Rakefile.setup FunWith::Gems, self

# Completely pointless wrapper for Jeweler::Tasks.new
FunWith::Gems::Rakefile.specification do |gem|
  # gem is a Gem::Specification... see http://guides.rubygems.org/specification-reference/ for more options
  gem.name        = "fun_with_gems"
  gem.homepage    = "http://github.com/darthschmoo/fun_with_gems"
  gem.license     = "MIT"
  gem.summary     = "Dependency for most of my FunWith:: gems.  Not much use standalone."
  gem.description = "Dependency for FunWith gems, simplifies the setup of new gems, installing version data, root filepath, and default requirements."
  gem.email       = "keeputahweird@gmail.com"
  gem.authors     = ["Bryce Anderson"]
  # dependencies defined in Gemfile
  
  gem.files = Dir.glob( File.join( ".", "lib", "**", "*.rb" ) ) + 
              Dir.glob( File.join( ".", "test", "**", "*" ) ) +
              %w( Gemfile Rakefile LICENSE.txt README.rdoc VERSION CHANGELOG.markdown )  
end

FunWith::Gems::Rakefile.setup_gem_boilerplate
