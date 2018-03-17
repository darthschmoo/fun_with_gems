require 'helper'

class TestTheTestCase < FunWith::Gems::TestCase
  context "putting a test case through its paces" do
    should "have the methods installed" do
      assert_respond_to( self, :gem_to_test )
      assert_respond_to( self.class, :gem_to_test )
    end
    
    should "know which gem is being tested" do
      assert_equal FunWith::Gems, self.gem_to_test
      assert_equal FunWith::Gems, self.class.gem_to_test
    end
  end
end