# Create new modules if necessary.
module FunWith
  module Gems
    class LibraryRequirer
      def self.require( *args, &block )
        self.new.require( *args, &block )
      end
      
      def require( const, opts )
        caller_file = opts[:caller] || guess_caller_file_name( const )
        files_to_require = const.root( "lib" ).glob(:all, :recursive => false) - [ caller_file ]
        files_to_require.flatten!
        
        for file in files_to_require
          file.requir
        end
      end
      
      def guess_caller_file( const )
        if const.respond_to?(:root)
          const_name = constant_name_to_filename( const.name )
          "lib/" + const_name
        else
          false
        end
      end
      
      # We're guessing.  It doesn't have to be perfect, but perfect 99% of the time would be nice
      def constant_name_to_filename( cname )
        cname.split("::").map{ |chunk|
          buffer = []
          chunk.length.times do |i|
            char = chunk[i]
            next_char = chunk[i+1] || :eof
            
            cap_letter = char == char.upcase
            next_cap_letter = next_char == next_char.upcase
            
            if cap_letter && ! next_cap_letter && i > 0
              buffer << "_"
            end
            
            buffer << char
          end
          
                    # chunk.gsub( /(.)([A-Z])/ ){ $1 + "_" + $2 }.downcase
          buffer.join("").downcase
                    
        }.join("/") + ".rb"
          
      end
    end
  end
end
