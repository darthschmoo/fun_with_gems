module FunWith
  module Gems
    # If the gem has a ::Testing::TestCaseExtensions module, (<GEM_ROOT>/lib/<GEM_NAME>/testing/test_case_extensions.rb)
    # include the module in FunWith::Testing::TestCase
    #
    # Best practice: reserve the TestCaseExtensions module for methods that you want to be available to any gem that
    # includes the gem being extended.  
    class TestCaseExtender
      def self.extend_test_case( *args, &block )
        self.new.extend_test_case( *args, &block )
      end
      
      # If the caller doesn't specify a class to be extended, 
      # assumes the target is FunWith::Testing::TestCase
      def extend_test_case( gem_const, test_case_class = nil )
        if test_case_class.nil?
          return false unless defined?( FunWith::Testing::TestCase )
          test_case_class = FunWith::Testing::TestCase
        end
        
        if defined?( gem_const::Testing::TestCaseExtensions )
          test_case_class.extend( gem_const::Testing::TestCaseExtensions )
        end
      end
    end
  end
end
