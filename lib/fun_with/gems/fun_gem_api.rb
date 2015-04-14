module FunWith
  module Gems
    module FunGemAPI
      def is_fun_gem?
        true
      end
      
      def validate_gem
        errors = FunWith::Gems::Validator.validate self
        errors
      end
      
      def valid_gem?
        errors = self.validate_gem
        errors.fwf_blank?
      end
      
      def passes_tests?
        TestSuiteRunner.new( self ).passes_tests?
      end
      
      def gem_test_mode?
        @fwg_gem_test_mode || false
      end
      
      # I can't think of a compelling reason to go beyond true/false here
      def gem_test_mode=( mode )
        @fwg_gem_test_mode = mode
      end
      
      def gem_verbose?
        @fwg_gem_verbose || false      # rather return false than nil
      end
      
      def gem_verbose=( mode )
        @fwg_gem_verbose = mode
      end
        
      def say_if_verbose( msg, stream = $stdout )
        stream.puts( msg ) if gem_verbose?
      end
      
      
      def load_tasks
        load_internal_tasks
        load_external_tasks
      end
      
      # Tasks in gem/tasks should be those which are specific to the gem itself.
      # Tasks located here will not be made available to gems which depend on it.
      # Made accessible during the Rakefile.setup
      def load_internal_tasks
        _load_tasks_from_directory self.root( "tasks" )
      end
      
      # Tasks in gem/lib/tasks will be usable by gems which have this gem as a dependency.
      def load_external_tasks
        _load_tasks_from_directory self.root( "lib", "tasks" )
      end
      
      def _load_tasks_from_directory dir
        if _rake_gem_loaded?
          dir.glob do |file|
            if file.file? && ( file.ext == "rb" || file.ext == "rake" )
              Rake.load_rakefile file
            end
          end
        end
      end
      
      def _rake_gem_loaded?
        defined?( Gem ) && Gem.respond_to?( :loaded_specs ) && defined?( Rake ) && Gem.loaded_specs.keys.include?( "rake" )
      end
    end
  end
end