module FunWith
  module Gems
    class ApiExtender
      def self.extend_with_api( *args, &block )
        self.new.extend_with_api( *args, &block )
      end
      
      def extend_with_api( const )
        if defined?( const::GemAPI )
          const.extend( const::GemAPI )
        elsif defined?( const::API )
          const.extend( const::API )
        end
      end
    end
  end
end
        