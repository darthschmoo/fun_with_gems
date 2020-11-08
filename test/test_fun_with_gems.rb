require 'helper'

class TestFunWithGems < FunWith::Gems::TestCase
  context "checking the plumbing of FunWith::Gems" do
    should "have FunWith::Gems constants defined" do
      assert defined?( FunWith )
      assert defined?( FunWith::Gems )
      assert defined?( FunWith::Gems::GemAPI )
    end
    
    should "be a proper gem" do
      assert_respond_to( FunWith::Gems, :version )
      assert_respond_to( FunWith::Gems, :is_fun_gem? )
      assert( FunWith::Gems.is_fun_gem? )
    end
    
    should "be a proper gem (using the assertion method provided by Testing::Assertions)" do
      assert_fun_gem( FunWith::Gems )
    end
    
    should "respond to API methods" do
      assert_respond_to( FunWith::Gems, :root )
      assert_respond_to( FunWith::Gems, :version )
      assert_respond_to( FunWith::Gems, :make_gem_fun )

      assert_kind_of( FunWith::VersionStrings::VersionString, FunWith::Gems.version )
      assert_kind_of( FunWith::Files::FilePath, FunWith::Gems.root )
    end
    
    should "have FunWith::Files constants" do
      assert defined?( FunWith::Files )
      assert defined?( FunWith::Files::FilePath )
      assert defined?( FunWith::Files::RootPath )
      assert defined?( FunWith::Files::DirectoryBuilder )
    end
    
    should "respond to fwf_...() methods" do
      assert_respond_to( "", :fwf_blank? )
      assert_respond_to( "", :fwf_present? )
      
      assert_respond_to( Set.new, :fwf_blank? )
      assert_respond_to( Set.new, :fwf_present? )
    end
    
    should "validate self" do
      assert FunWith::Gems.valid_gem?
    end
  end
end
