module FunWith
  module Llamas
    class Trainer
      attr_accessor :name
      
      def initialize( name )
        @name = name
      end
      
      def brush( llama )
        llama.brushed_by( self )
      end
    end
  end
end