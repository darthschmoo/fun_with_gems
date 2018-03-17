module FunWith
  module Gems
    # TODO: Move all validation / testing code to fun_with_gemdev
    class Validator
      def self.validate( gem_const )
        self.new( gem_const ).validate
      end
      
      def initialize( gem_const )
        @gem_const = gem_const
      end
      
      # should be available via the gem itgem_const?
      def validate
        @fun_gem_errors = []
        
        if @gem_const.respond_to?(:root)
          if @gem_const.root.is_a?( FunWith::Files::FilePath )
            @fun_gem_errors << ".root() doesn't exist"                unless @gem_const.root.directory?
            @fun_gem_errors << "VERSION file doesn't exist"           unless @gem_const.root("VERSION").file?
            @fun_gem_errors << "CHANGELOG.markdown doesn't exist"     unless @gem_const.root("CHANGELOG.markdown")
            @fun_gem_errors << "lib directory doesn't exist"          unless @gem_const.root("lib").directory?
          else
            @fun_gem_errors << ".root() doesn't give a filepath"
          end
        else
          @fun_gem_errors << "doesn't respond to .root()"
        end
        
        if ! @gem_const.respond_to?(:version)
          @fun_gem_errors << "doesn't respond to .version()"
        end
        
        @fun_gem_errors
      end
      
      def fun_gem_errors
        @fun_gem_errors
      end
      
      def git_up_to_date?( filepath )
        # On branch master
        #         Your branch is ahead of 'origin/master' by 1 commit.
        #           (use "git push" to publish your local commits)
        # 
        #         nothing to commit, working directory clean
        #         
      end
    end
  end
end