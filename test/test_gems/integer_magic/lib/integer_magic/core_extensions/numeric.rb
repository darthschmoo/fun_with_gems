module IntegerMagic
  module CoreExtensions

    # uses the simpler module definition (none of the ::ClassMethods / ::InstanceMethods submodule nonsense)
    # but still gets included properly
    module Numeric
      def integer?
        self.is_a?( Integer )
      end
    end
  end
end

