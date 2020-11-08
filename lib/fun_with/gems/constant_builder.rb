module FunWith
  module Gems
    class ConstantBuilder
      def self.build_constant( *args, &block )
        self.new.build_constant( *args, &block )
      end
      
      # Expecting that constants will only be passed as strings when the constants hasn't been previously defined.
      #
      # returns the constant
      def build_constant( c )
        if c.is_a?( String )
          #create the module
          const = Object
          
          # go down the ::Module stack, creating modules along the way
          full_const_name = ""
          c.split("::").each do |module_name|
            full_const_name << "::" unless full_const_name.fwf_blank?
            full_const_name << module_name
            
            if eval( "defined?(#{full_const_name})")
              const = eval( full_const_name )
            else
              const = const.const_set( module_name, Module.new )
            end
          end
        
          eval( c )
        else
          c
        end
      end
    end
  end
end