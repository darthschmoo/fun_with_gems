# This example uses the inclusionize system
module ArrayInheritsEnumerable
  module CoreExtensions
    module Numeric
      module Constants
        COUNTLESS = Float::INFINITY
      end
      
      module ClassMethods
        def give_me_a_random_number
          :no
        end
      end
      
      module InstanceMethods
        def prime?
          :maybe
        end
      end
    end
  end
end