require "fun_with_version_strings"
require "fun_with_files"

# FunWith::VersionStrings.versionize( FunWith::Files )

lib_dir = __FILE__.fwf_filepath.dirname
lib_dir.join( "fun_with", "gems", "gem_api.rb" ).requir
lib_dir.join( "fun_with", "gems", "fun_gem_api.rb" ).requir
# 
# require File.join( File.dirname( __FILE__ ), "fun_with", "gems", "gem_api" )
# require File.join( File.dirname( __FILE__ ), "fun_with", "gems", "fun_gem_api" )

FunWith::Gems.extend( FunWith::Gems::GemAPI )

# versionizes
# rootifies
# requir's the lib/fun_with directory
# Do this because FunWithFiles doesn't do it itself.  
FunWith::Gems.make_gem_fun( FunWith::Files, :require => false, :set_root => false, :set_version => false )
FunWith::Gems.make_gem_fun( "FunWith::Gems" )