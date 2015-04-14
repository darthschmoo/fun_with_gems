module FunWith
  module Gems
    class TestSuiteRunner
      attr_accessor :gem_const
      
      def initialize fwgem
        self.gem_const = fwgem
      end
      
      def passes_tests?
        result = self.run_tests
        result.passed?
      end
      
      def run_tests
        filepath = self.gem_const.root
        
        results = TestResults.new( self.gem_const )
        
        puts "running tests on #{self.gem_const} from #{filepath}"
        results.output = `cd #{filepath} && rake test`
        results
      end
    end
  end
end