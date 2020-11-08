module FunWith
  module Gems
    module Testing
      class TestSetup
        def self.setup( gem )
          gem.gem_test_mode = true
          require_test_libs( gem )
        end
      
        def self.require_test_libs( gem )
          return false unless gem.respond_to?(:root)
          groot = gem.root
          return false unless groot.is_a?( FunWith::Files::FilePath )
          
          test_lib_dir = groot / :test / :lib
          test_lib_dir.requir if test_lib_dir.directory?
        end
      end
    end
  end
end
          