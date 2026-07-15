module FunWith
  module Gems
    module GemAPI
      # Very opinionated.  Expects the function to be called in the gem's lib/gem_name.rb file.
      # Also expects a VERSION file at the root of the gem, which has "0.0.3" (or whatever), and 
      # nothing else.  Finally, it expects that 'requiring' the classes the gem needs is a simple
      # matter of requiring every item in the lib/fun_with directory, so keep those classes clean.
      # The string given should represent the module that refers to the gem as a whole.
      # 
      # Configurable options:
      # While all these things are handled by default, some things can be overridden
      # :root => or render :main_lib_file moot by declaring a different root.
      # 
      # :version => Declare a different version string for the gem.
      # 
      # :require => false (avoids requiring the default lib/fun_with dir.)
      # :require => filepath or array of filepaths   (require these things instead (note: not in addition to))
      # :core_extensions => false           (don't autoload Gem::CoreExtension modules)
      #                                     (note that it still checks to see if the module's already been included)
      #
      # :main_lib_file => use a different filepath to calculate the root (defaults to <GEM_ROOT>/)
      # :configuration => nil (tries to load configuration from <GEM_ROOT>/config/gem_config.rb, if such a file exists)
      #                   (String) --> assumes it's been given a filename
      #                   (Hash) --> converts to a FunWith::Configurations::Config
      #                   (Config) --> uses as the configuration
      #                   :skip --> don't bother installing a configuration
      #
      #                   If successful, the configuration will be accessible from <GEM_CONST>.config
      def make_gem_fun( gem_const, opts = {} )
        @caller_file = caller.first.gsub(/:\d+:.*/,'').fwf_filepath
        @opts = opts
        
        
        
        @gem_const = build_gem_const( gem_const )
        @gem_const.extend( FunGemAPI )
        set_gem_root                   unless @opts[:set_root] == false
        set_gem_version                unless @opts[:set_version] == false
        @gem_const.gem_verbose = opts[:verbose]
        
        # false to skip requiring entirely
        # an array to load both
        require_libs                   unless @opts[:require] == false
        
        extend_constant_with_gem_api   unless @opts[:gem_api] == false  
        
        @gem_const.load_external_tasks  # Nothing happens unless 'rake' gem is active
        
        include_core_extensions        unless @opts[:core_extensions] == false
        
        # GemName.config.{configuration_settings} if applicable
        # Only runs if "fun_with_configurations" is required prior to
        # calling files.  Really starting to wonder about that.  Should fwc 
        # stop depending on
        install_gem_configuration      unless @opts[:configuration] == :skip
        
        extend_test_case
        
        @gem_const 
      end
      
      def inclusionize( base )
        FunWith::Gems::Inclusionizer.inclusionize( base )
      end
      
      protected
      def build_gem_const( gem_const )
        ConstantBuilder.build_constant( gem_const )
      end
      
      def set_gem_root
        RootSetter.set_root( @gem_const, @caller_file, @opts )
      end
      
      def set_gem_version
        Versionizer.versionize( @gem_const, @opts[:version] )
      end
      
      def require_libs
        opts = just_options( @opts, :require, :main_lib_file ).merge( :caller => @caller_file )
        LibraryRequirer.require( @gem_const, opts )
      end
      
      def extend_constant_with_gem_api
        ApiExtender.extend_with_api( @gem_const )
      end
      
      # Files in <GEM_ROOT>/lib/core_extensions get included in their corresponding core class?
      def include_core_extensions
        CoreExtender.extend_core( @gem_const )
      end
      
      # Install a configuration given as an argument,
      # or install the default config/gem_config.rb if such a file exists
      def install_gem_configuration
        opts = just_options( @opts, :configuration )
        ConfigurationInstaller.install_configuration( @gem_const, opts )
      end
      
      # @gem_const::Testing::TestCaseExtensions should already be loaded
      # if it exists.  Uses it to extend FunWith::Testing::TestCase
      def extend_test_case
        TestCaseExtender.extend_test_case( @gem_const )
      end
      
      protected
      def just_options( opts, *args )
        {}.tap do |return_opts|
          for arg in args
            return_opts[arg] = opts[arg].dup if opts.has_key?( arg )
          end
        end
      end
    end
  end
end