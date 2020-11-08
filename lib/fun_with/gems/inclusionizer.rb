module FunWith
  module Gems
    module Inclusionizer
      def self.inclusionize( base )
        base.send( :include, self )
      end
      
      def self.included( base )
        # overwrite the base class's self.included()
        base.send( :extend, self::SelfIncludedMethod )
      end

      module SelfIncludedMethod
        def included( base )
          __self = self

          if base.is_a?(Module)
            base.module_eval do
              extend  __self::ClassMethods     if defined?( __self::ClassMethods )
              include __self::InstanceMethods  if defined?( __self::InstanceMethods )
              include __self::Constants        if defined?( __self::Constants )
            end
          elsif base.is_a?(Class)
            base.class_eval do
              extend  __self::ClassMethods     if defined?( __self::ClassMethods )
              include __self::InstanceMethods  if defined?( __self::InstanceMethods )
              include __self::Constants        if defined?( __self::Constants )
            end
          end
        end
      end
    end
  end
end
