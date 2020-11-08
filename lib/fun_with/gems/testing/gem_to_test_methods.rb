module FunWith
  module Gems
    module Testing
      module GemToTestMethods
        # TODO: should use Inclusionizer?
        def self.included( klass )
          klass.extend( ClassMethods )
          klass.extend( Constants )
          klass.send( :include, InstanceMethods )
        end
      
      
        module ClassMethods
          # What FunWith::Gems - derived gem is being tested?  check as far up the class tree as needed.
          def gem_to_test
            @gem_to_test ||= nil
            rval = @gem_to_test
            rval = self.superclass.gem_to_test if !rval && self.superclass.respond_to?( :gem_to_test )
            rval
          end
          
          attr_writer :gem_to_test
        end
      
        module InstanceMethods
          def gem_to_test
            self.class.gem_to_test
          end
        end
      
        module Constants
          GEM_TO_TEST_METHODS_LOADED = true
        end
      end
    end
  end
end