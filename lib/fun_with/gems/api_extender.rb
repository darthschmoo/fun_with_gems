module FunWith
  module Gems
    class ApiExtender
      def self.extend_with_api( *args, &block )
        self.new(*args,&block).extend_with_api
      end
      
      def initialize(const)
        @const = const
      end
      
      def extend_with_api
        api = get_gem_api_module
        
        if api.is_a?(Module)
          @const.extend( api )
        end
      end
      
      def get_gem_api_module
        existing_gem_api_constant || load_api_constant
      end
      
      def load_api_constant
        if @const.respond_to?(:root)
          rootpath = @const.root / :lib
          gem_api_path = @const.to_s.gsub("::","/").gsub(/(.)([A-Z])/,'\1_\2').downcase
          
          path = rootpath / gem_api_path
          
          require path if path.ext(:rb).file?
          existing_gem_api_constant            # maybe it exists now?
        end
      end
      
      def existing_gem_api_constant
        return @const::GemAPI if defined?(@const::GemAPI)
        return @const::API    if defined?(@const::API)
        return @const::GemApi if defined?(@const::GemApi)
        
        return nil
      end
    end
  end
end
        