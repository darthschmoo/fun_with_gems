require 'helper'

class TestLibraryRequirer < FunWith::Gems::TestCase
  context "testing guess_caller_file()" do
    should "meet expectations" do
      lb = LibraryRequirer.new
      
      assert_equal "hello_there/world.rb", lb.constant_name_to_filename( "HelloThere::World" )
      assert_equal "swing_set/api_manager.rb", lb.constant_name_to_filename( "SwingSet::APIManager" )
      assert_equal "tasks.rb", lb.constant_name_to_filename( "Tasks" )
    end
  end
end
