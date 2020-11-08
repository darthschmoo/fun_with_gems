module FunWith
  module Gems
    class Versionizer
      TRAILING_VERSION_STRING_MATCHER = /(?<=-)(\d|\.)+$/
      
      def self.versionize( *args )
        self.new.versionize( *args )
      end
      
      def versionize( gem_const, version_string = nil )
        version_string = infer_version_string_for_gem( gem_const )
        FunWith::VersionStrings.versionize( gem_const, version_string ) if version_string.fwf_present?
      end
      
      protected
      def infer_version_string_for_gem( gem_const, version_string = nil )
        version_string || version_string_from_gem_version_file( gem_const ) || version_string_from_gem_folder( gem_const )
      end
      
      def version_string_from_gem_version_file( gem_const )
        if gem_const.respond_to?(:root) 
          vfile = gem_const.root( "VERSION" )
          (vfile.file? && vfile.readable?) ? vfile.read : nil
        else
          nil
        end
      end
      
      # most gems get installed into a rubygems folder under the folder name <gem_name>-X.XX.X
      def version_string_from_gem_folder( gem_const )
        if gem_const.respond_to?(:root)
          if m = gem_const.root.path.match( TRAILING_VERSION_STRING_MATCHER )
            return m[0]
          end
        end
        
        return nil
      end
    end
  end
end