require "fun_with_version_strings"
require "fun_with_files"
lib_dir = __FILE__.fwf_filepath.dirname
lib_dir.join( "fun_with", "gems", "gem_api.rb" ).requir
lib_dir.join( "fun_with", "gems", "fun_gem_api.rb" ).requir

FunWith::Gems.extend( FunWith::Gems::GemAPI )

# Skip the things FunWith::Files does for itself
FunWith::Gems.make_gem_fun FunWith::Files, :require => false, :set_root => false, :set_version => false
FunWith::Gems.make_gem_fun FunWith::Gems

# FunWith::Gems::Rakefile.extend FunWith::Gems::RakeClassMethods 
