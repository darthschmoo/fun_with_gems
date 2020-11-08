module FunWith
  module Gems
    class ConfigurationInstaller
      def self.install_configuration( *args, &block )
        self.new.install_configuration( *args, &block )
      end
      
      def install_configuration( gc, opts = {} )
        cfg = opts.fetch(:configuration){ false }
        
        if configuration_needed?( gc, cfg )
          return false unless load_fun_with_configurations
          
          cfg = get_configuration( gc, cfg )
          
          if cfg.is_a?( FunWith::Configurations::Config )
            gc.install_fwc_config( cfg )
          end
        end
      end
      
      protected
      # If no configuration (or file) was passed in as an argument and a magic file doesn't exist 
      # for the gem configuration, don't do anything
      def configuration_needed?( gc, cfg = false )
        return false if cfg == :skip
        return true if cfg                                 # user has provided a configuration
        # a configuration has already been installed, or .config() is already defined
        return false if gc.respond_to?( :config )          
        
        # returns false if there's no magic file below the gem's root
        gem_default_configuration_file( gc ) ? true : false
      end
      
      # 
      def load_fun_with_configurations
        require 'fun_with_configurations' unless defined?( FunWith::Configurations )
        true
      rescue LoadError
        false
      end
      
      # returns a FunWith::Configurations::Config option which can be installed on the gem
      #
      # if 
      def get_configuration( gc, cfg )
        case cfg
        when :skip
          return false      # don't try to install a configuration, not even the default one
        when FunWith::Configurations::Config
          return cfg
        when Hash
          return FunWith::Configurations::Config.from_hash( cfg )
        when FunWith::Files::FilePath
          return get_configuration_from_file( cfg )
        when String
          # assume we've been given a filepath
          return get_configuration_from_file( cfg.fwf_filepath )
        when false
          # 
          return get_configuration_from_file( gem_default_configuration_file( gc ) ) # returns 
        end
      end
      
      def get_configuration_from_file( f )
        return false if f == false
        (f.file? && f.readable?) ? FunWith::Configurations::Config.from_file( f ) : false
      end
      
      # Default configuration file is either <GEM_ROOT>/config/gem_config.(yml or rb).
      # If both exist, the .rb file is returned
      def gem_default_configuration_file( gc )
        return false unless gc.respond_to?(:root)
        config_dir = gc.root / :config
        
        for filename in ["gem_config.rb", "gem_config.yml", "gem_config.yaml"]
          f = config_dir / filename
          
          return f if (f.file? && f.readable?)
        end
        
        return false
      end
    end
  end
end
