module FunWith
  module Gems
    module Testing
      # Extensions to the FunWith::Testing::TestCase class.  
      module TestCaseExtensions
        # config options
        #    :factory_bot => true   : load FactoryBot factory definitions from the places FactoryBot expects them to live.
        #    :include => true       : include the namespace of the gem being tested.
        def make_testing_fun( testable_gem, config = {} )
          include GemToTestMethods
          install_basic_assertions           # The assertions included by FunWith::Testing
          install_gem_assertions             # The assertions included by FunWith::Gems
          install_yet_more_assertions( testable_gem )
          
          self.gem_to_test = testable_gem
        
          self.add_factorybot_support if config[:factory_bot] == true
          self.send( :include, self.gem_to_test ) if config[:include] == true
        end
      
        def install_gem_assertions
          include FunWith::Gems::Testing::Assertions
        end
        
        def install_yet_more_assertions( testable_gem )
          if testable_gem.respond_to?( :root )
            f = testable_gem.root( :test, "assertions.rb" )
            
            require f if f.file?
          end
          
          if defined?( testable_gem::Testing::Assertions )
            
          end
        end
      end
    end
  end
end