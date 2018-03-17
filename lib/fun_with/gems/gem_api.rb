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
      # :main_lib_file => use a different filepath to calculate the root
      #
      # :root => or render :main_lib_file moot by declaring a different root.
      # 
      # :version => Declare a different version string for the gem.
      # 
      # :require => false (avoids requiring the default lib/fun_with dir.)
      # :require => filepath or array of filepaths   (require these things instead (note: not in addition to))
      def make_gem_fun( gem_const, opts = {} )
        
        @caller_file = caller.first.gsub(/:\d+:.*/,'').fwf_filepath
        @opts = opts
        set_gem_const( gem_const )
        @gem_const.extend( FunGemAPI )
        set_gem_root
        set_gem_version
        require_libs
        extend_constant_with_gem_api
        @gem_const.gem_verbose = opts[:verbose]
        @gem_const.load_external_tasks  # Nothing happens unless 'rake' gem is active
      end
      
      protected
      def set_gem_const( gem_const )
        # Create new modules for this fun, fun gem, if necessary.
        if gem_const.is_a?( String )
          #create the module
          const = Object
          full_const_name = ""
          gem_const.split("::").each do |module_name|
            full_const_name << "::" unless full_const_name.fwf_blank?
            full_const_name << module_name
            
            if eval( "defined?(#{full_const_name})")
              const = eval( full_const_name )
            else
              const = const.const_set( module_name, Module.new )
            end
          end
        
          @gem_const = eval( gem_const )
        else
          @gem_const = gem_const
        end
      end
      
      def set_gem_root
        return if @opts[:set_root] == false
        
        # Hence, the "make_gem_fun()" directive should be called in the lib/gem_name.rb file.
        main_lib_file = @opts[:main_lib_file] || @caller_file
        root = @opts[:root] || main_lib_file.fwf_filepath.expand.dirname.up
        
        Files::RootPath.rootify( @gem_const, root )
      end

      def set_gem_version
        return if @opts[:set_version] == false
        if @opts[:version]
          VersionStrings.versionize( @gem_const, @opts[:version] )
        else
          VersionStrings.versionize( @gem_const )
        end
      end
      
      def require_libs
        unless @opts[:require] == false
          @opts[:require] ||= @gem_const.root( "lib" ).glob(:all, :recursive => false) - [ @caller_file ]
          @opts[:require] = [ @opts[:require] ] unless @opts[:require].is_a?(Array)
        
          @opts[:require].each do |req_dir|
            req_dir.fwf_filepath.expand.requir
          end
        end
      end
      
      def extend_constant_with_gem_api
        if defined?( @gem_const::GemAPI )
          @gem_const.extend( @gem_const::GemAPI )
        end
      end
    end
  end
end