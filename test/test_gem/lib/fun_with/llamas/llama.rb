module FunWith
  module Llamas
    class Llama
      attr_accessor :name
      
      def initialize( name )
        @name = name
        @regards = {}
      end
      
      def scorns( trainer )
        remember_trainer( trainer )
        @regards[ trainer.name ] -= 1
      end
      
      # Ptooi!
      def spit( trainer )
        remember_trainer( trainer )
        @regards[ trainer.name ] -= 1
      end

      def brushed_by( trainer )
        remember_trainer( trainer )
        @regards[ trainer.name ] += 1
      end
      
      def remember_trainer( trainer )
        @regards[ trainer.name ] ||= 0
      end
      
      def knows?( trainer )
        @regards.has_key?( trainer.name )
      end
      
      def trainer_score( trainer )
        @regards[ trainer.name ]
      end
    end
  end
end