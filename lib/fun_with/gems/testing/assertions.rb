module FunWith
  module Gems
    module Testing
      module Assertions
        # Puts a gem through its paces
        def assert_gem_is_fine( gem )
          flunk
        end
        
        def assert_fun_gem( gem )
          assert_kind_of( Module, gem )
          assert_respond_to gem, :is_fun_gem?
          assert gem.is_fun_gem?
        end
        
        def assert_version( gem, version )
          
        end
      end
    end
  end
end