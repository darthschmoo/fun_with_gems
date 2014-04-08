module FunWith
  module Gems
    
    class Mechanic
      def bump_version( gem_const )
        if Validator.new.validate( gem_const )
        # if tests pass and gem is valid
        
          # run rake version:bump:patch
        
          # git commit
        
          # git push
        
          # add branch v<VERSION>
        
          # rake install
        
          # gem push
        
        else
          puts "Failed"
        end
      end
    end
  end
end