module IntegerMagic
  module CoreExtensions
    module Integer       # the CoreClassName
      include FunWith::Gems::Inclusionizer

      module Constants
        ZERO = 0
        HIGHEST_PRIME_NUMBER = 9
      end

      module ClassMethods
        def thinking_of_a_number_between_zero_and( n )
          return :you_guessed_correctly
        end
      end

      module InstanceMethods
        def even?
          self % 2 == 0
        end

        def odd?
          self % 2 == 1
        end
      end
    end
  end
end
