require 'helper'

class TestTheTestCase < FunWith::Gems::TestCase
  context "putting a test case through its paces" do
    should "have GemToTest methods installed" do
      assert_respond_to self, :gem_to_test
      assert_respond_to self.class, :gem_to_test
    end
    
    should "have external fun_gem assertions installed" do
      assert_respond_to self, :assert_gem_is_fine
      assert_respond_to self, :assert_fun_gem
    end
    
    should "know which gem is being tested" do
      assert_equal FunWith::Gems, self.gem_to_test
      assert_equal FunWith::Gems, self.class.gem_to_test
    end
    
    should "have assertions from test/assertions.rb available within this test suite" do
      assert_respond_to self, :assert_example_assertion
    end
  end
end