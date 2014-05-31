module FunWith
  module Gems
    module FunGemAPI
      def is_fun_gem?
        true
      end
      
      def validate_gem
        FunWith::Gems::Validator.new( self ).validate
      end
      
      def valid_gem?
        self.validate_gem.fwf_blank?
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
    end
  end
end