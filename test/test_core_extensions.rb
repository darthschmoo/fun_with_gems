require 'helper'

class TestCoreExtensions < FunWith::Gems::TestCase
  context "testing core extensions" do
    should "have this test under core extensions" do
      assert_respond_to( Module.new, :is_fun_gem? )
      assert_false( Module.new.is_fun_gem? )
    end
  end
end