
module FunWith
  module Gems
    module Testing
      # This is where you put custom assertions that only need to be available to the gem's test suite.
      # To make an assertion available to a gem that uses this gem as a dependency, put it in
      # <GEM_ROOT>/lib/<GEM>/testing/assertions.rb
      module Assertions
        def assert_example_assertion
          assert true
        end
      end
    end
  end
end