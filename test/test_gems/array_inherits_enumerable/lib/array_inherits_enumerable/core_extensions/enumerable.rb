module ArrayInheritsEnumerable
  module CoreExtensions
    module Enumerable
      def array_should_have_this_method(*args)
        puts args.inspect
      end
    end
  end
end
      