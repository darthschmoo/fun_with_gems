module FunWith
  module Gems
    class TestResults
      TEST_SUITE_DATA_REGEX = /(?<tests>\d+) (?:tests|runs), (?<assertions>\d+) assertions, (?<failures>\d+) failures, (?<errors>\d+) errors, (?<skips>\d+) skips/
      
      attr_accessor :output, :test_results_found, :gem_const, :fail_count
      
      def initialize g
        self.gem_const = g
      end
      
      def passed?
        self.scan_test_results
        self.test_results_found? && no_failures_or_errors?
      end
      
      def test_results_found?
        self.test_results_found
      end
      
      def no_failures_or_errors?
        fail_count == 0
      end
      
      def scan_test_results
        raise "No output to scan!" if self.output.nil?
        
        if m = self.output.match( TEST_SUITE_DATA_REGEX )
          self.test_results_found = true
          self.fail_count = m[:failures].to_i + m[:errors].to_i
        else
          self.fail_count = -1
          self.test_results_found = false
        end
      end
    end
  end
end
