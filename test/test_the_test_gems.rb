require 'helper'

class TestTheTestGems < FunWith::Gems::TestCase
  def load_llamas
    load_gem( :llamas )
  end
  
  def load_integer_magic
    load_gem( :integer_magic )
  end
  
  def load_array_inherits_enumerable
    load_gem( :array_inherits_enumerable )
  end

  def load_gem( g )
    @test_gem_dir = FunWith::Gems.root( "test", "data", "test_gems" )
    
    case g
    when :llamas
      @test_gem_dir.join( "fun_with_llamas", "lib", "fun_with_llamas.rb" ).requir
      assert defined?( FunWith::Llamas )
    when :integer_magic
      @test_gem_dir.join( "integer_magic", "lib", "integer_magic.rb" ).requir
      assert defined?( IntegerMagic )
    when :array_inherits_enumerable
      @test_gem_dir.join( "array_inherits_enumerable", "lib", "array_inherits_enumerable.rb" ).requir
    end
  end
  
  context "testing gem loading" do
    setup do
      # load Llama gem
      load_llamas
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
  
  context "testing core_extension functionality" do
    setup do
      load_integer_magic
    end
    
    should "load IntegerMagic gem" do
      assert defined?( IntegerMagic )
      assert_fun_gem( IntegerMagic )
      assert_version( IntegerMagic, "3.1.4" )
    end
    
    should "successfully load core_extension modules" do
      assert defined?( IntegerMagic::CoreExtensions::Integer )
      assert defined?( IntegerMagic::CoreExtensions::Numeric )
      assert defined?( IntegerMagic::CoreExtensions::Integer::Constants )
      assert defined?( IntegerMagic::CoreExtensions::Integer::InstanceMethods )
      assert defined?( IntegerMagic::CoreExtensions::Integer::ClassMethods )
    end
    
    should "include core_extension functionality on Integer and Numeric" do
      assert_respond_to( 6, :odd? )
      assert_respond_to( 5, :even? )
      refute 6.odd?
      refute 5.even?
      
      assert_respond_to( 4.1, :integer? )
      assert_respond_to( Integer, :thinking_of_a_number_between_zero_and )
      assert_equal( :you_guessed_correctly, Integer.thinking_of_a_number_between_zero_and( 1_000_000 ) )
      assert_zero( Integer::ZERO )
    end
  end
  
  context "testing install of default configurations" do
    setup do
      load_integer_magic
    end
    
    # To make this test pass, I'll need to clear out the fun_gem cruft from FunWith::Configurations,
    # then make FunWith::Gems dependent on it rather than vice versa.
    should "load a default configuration" do
      assert_respond_to( IntegerMagic, :config ) if defined?( FunWith::Configurations )
    end
  end
  
  context "load ArrayInheritsEnumerable gem" do
    setup do
      load_array_inherits_enumerable
    end
    
    should "extend Enumerable" do
      assert defined?( ArrayInheritsEnumerable::CoreExtensions::Enumerable )
      assert_includes( Enumerable.included_modules, ArrayInheritsEnumerable::CoreExtensions::Enumerable )
      assert_includes( Enumerable.instance_methods, :array_should_have_this_method )
      
      assert_respond_to( [], :array_should_have_this_method )
      assert_respond_to( {}, :array_should_have_this_method )
      assert_respond_to( Set.new, :array_should_have_this_method )
    end
    
    should "extend Comparable" do
      assert defined?( ArrayInheritsEnumerable::CoreExtensions::Comparable )
      assert_includes( Comparable.included_modules, ArrayInheritsEnumerable::CoreExtensions::Comparable )
      assert_includes( Comparable.instance_methods, :string_should_have_this_method )
      
      assert_respond_to( "", :string_should_have_this_method )
      assert_respond_to( 3, :string_should_have_this_method )     # because Integer is also Comparable
      assert_equal( :it_does, Time.now.string_should_have_this_method ) # and so is Time
    end
    
    should "extend Numeric" do
      assert defined?( ArrayInheritsEnumerable::CoreExtensions::Numeric )
      assert_respond_to( 3, :prime? )
      assert_equal :maybe, 3.prime?
      
      assert_respond_to( Numeric, :give_me_a_random_number )
      assert_equal :no, Numeric.give_me_a_random_number
      assert_equal :no, Integer.give_me_a_random_number
      assert_equal :no, Float.give_me_a_random_number
      
      assert_greater_than 10 ** 100, Numeric::COUNTLESS
    end
  end
end