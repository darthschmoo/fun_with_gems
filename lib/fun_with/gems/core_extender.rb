module FunWith
  module Gems
    class CoreExtender
      def self.extend_core( *args, &block )
        self.new.extend_core( *args, &block )
      end
      
      def extend_core( gem_const )
        return false unless defined?( gem_const::CoreExtensions )
        
        ce = gem_const::CoreExtensions
        
        for mod in ce.constants
          if Object.const_defined?( mod )
            original = Object.const_get( mod )
            includable = ce.const_get( mod )
            include_in_core( original, includable )
          end
        end
      end
      
      protected
      def include_in_core( original, includable )
        unless original.included_modules.include?( includable )    # it's already been included, so don't bother.
          override_default_included_method( includable ) # basically gives it the inclusionizer treatment
          original.send( :include, includable )
          reinclude( original ) if original.is_a?( Module )
        end
      end
      
      def override_default_included_method( includable )
        # leave it alone if an #included() method is already defined, 
        # or if the module doesn't define the submodules that
        # the new #included() method expects it to.
        unless includable.respond_to?( :included ) || !( defined?(includable::ClassMethods) || defined?(includable::InstanceMethods) || defined?(includable::Constants) )
          Inclusionizer.inclusionize( includable ) 
        end
      end
      
      # There's something odd about Ruby. When you include a module into a module that is itself included in a class/module, the class/module
      # needs the included module to be re-included, otherwise stuff doesn't show up.
      def reinclude( const )
        silence_deprecation_warnings do
          @core_classes_and_modules = Object.constants.map{|sym| Object.const_get(sym) }.select{|cnst| cnst.is_a?(Class) || cnst.is_a?(Module)}
        
          for klass in @core_classes_and_modules
            if klass.included_modules.include?( const )
              klass.send( :include, const )
            end
          end
        end
      end
      
      
      # reinclude() pulls up a bunch of classes that have been marked as deprecated, and spits out warnings.
      def silence_deprecation_warnings(&block)
        old_stderr = $stderr
        $stderr = StringIO.new
        yield
      ensure 
        $stderr = old_stderr
      end
    end
  end
end