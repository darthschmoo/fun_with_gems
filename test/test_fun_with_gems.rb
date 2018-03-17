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
  
  context "testing gem loading" do
    setup do
      # load Llama gem
      FunWith::Gems.root( "test", "test_gem", "lib", "fun_with_llamas.rb" ).requir
    end
    
    should "load llama gem" do
      assert defined?( FunWith )
      assert defined?( FunWith::Llamas )
      assert defined?( FunWith::Llamas::Llama )
      assert defined?( FunWith::Llamas::Trainer )
      assert_respond_to( FunWith::Llamas::Llama.new( "Ella" ), :spit )

      assert_equal 3, FunWith::Llamas.version.major
      assert_equal 5, FunWith::Llamas.version.minor
      assert_equal 2, FunWith::Llamas.version.patch
      
      assert FunWith::Llamas.valid_gem?
    end
    
    should "extend the FunWith::Llamas gem with its GemAPI" do
      assert_respond_to( FunWith::Llamas, :can_make_the_llamas_dance? )
      assert FunWith::Llamas.can_make_the_llamas_dance?
    end
    
    should "demonstrate festive llama/trainer interaction" do
      trainer = FunWith::Llamas::Trainer.new( "Karsten" )
      llama   = FunWith::Llamas::Llama.new( "Babette" )
      
      assert_false llama.knows?( trainer )
      
      trainer.brush( llama )
      
      assert_true llama.knows?( trainer )
      
      assert_equal 1, llama.trainer_score( trainer )
    end
  end
end
