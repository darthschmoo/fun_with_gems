module FunWith
  module Gems
    class RootSetter
      def self.set_root( *args, &block )
        self.new.set_root( *args, &block )
      end
      
      def set_root( gem_const, caller_file, opts = {} )
        # Hence, the "make_gem_fun()" directive should be called in the lib/gem_name.rb file.
        main_lib_file = opts[:main_lib_file] || caller_file
        root = opts.fetch(:root){ main_lib_file.fwf_filepath.expand.dirname.up }
        
        Files::RootPath.rootify( gem_const, root )
      end
    end
  end
end

        