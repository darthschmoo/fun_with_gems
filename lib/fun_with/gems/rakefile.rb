module FunWith
  module Gems
    module Rakefile
      attr_accessor :gem
      
      def rakefile_setup this_gem   # , rake_main
        set_gem        this_gem
        # set_rake_main  rake_main
        run_bundler_setup
        
        # Internal tasks are set up in the Rakefile.  
        # External tasks (visible to the gems that depend on your fungem) are setup during the normal gem setup, if the 'rake' gem is present.
        get_gem.load_internal_tasks     
      end
      
      def set_gem g
        @gem = g
      end
      
      def get_gem
        @gem
      end
      
      # def set_rake_main m
      #   @rake_main = m
      # end
      
      def run_bundler_setup
        all_requirements
        
        begin
          Bundler.setup(:default, :development)
        rescue Bundler::BundlerError => e
          $stderr.puts e.message
          $stderr.puts "Run `bundle install` to install missing gems"
          exit e.status_code
        end
      end
      
      def gem_specification &block
        Juwelier::Tasks.new do |gem|
          yield gem
        end
      end
      
      def setup_gem_boilerplate
        # run_in_rakefile do
          Juwelier::RubygemsDotOrgTasks.new

          Rake::TestTask.new(:test) do |test|
            test.libs << 'lib' << 'test'
            test.pattern = 'test/**/test_*.rb'
            test.verbose = true
          end

          desc "Code coverage detail"
          task :simplecov do
            ENV['COVERAGE'] = "true"
            Rake::Task['test'].execute
          end

          task :default => :test

          Rake::RDocTask.new do |rdoc|
            version = File.exist?('VERSION') ? File.read('VERSION') : ""

            rdoc.rdoc_dir = 'rdoc'
            rdoc.title = "fun_with_gems #{version}"
            rdoc.rdoc_files.include('README*')
            rdoc.rdoc_files.include('lib/**/*.rb')
          end
          # end
      end
      
      def all_requirements
        # run_in_rakefile do
          require 'rake'
          require 'juwelier'
          
          begin
            require 'rdoc/task'
          rescue ArgumentError
            # warn( "what's up with this error when loading RDoc?" )
            require 'rdoc'
            require 'rdoc/task'
          end
          
          require 'rake/testtask'
          require 'bundler'
      end
      
      
      def add_specification_files( gem_specification, *args )
        gem_file_list = gem_specification.files
        
        root = "".fwf_filepath
        
        for arg in args
          case arg
          when :default
            gem_file_list += root.join( :bin ).glob
            gem_file_list += root.join( :config ).glob
            gem_file_list += root.join( :examples ).glob
            gem_file_list += [ "Gemfile", "Rakefile", "VERSION" ]
            gem_file_list += root.join( :lib ).glob( :all, :ext => :rb )
            gem_file_list += root.join( :lib ).glob( :all, :ext => :rake )
            gem_file_list += root.join( :test ).glob
            gem_file_list += root.entries.select{|p| p.path =~ /^LICENSE\./ }
            gem_file_list += root.entries.select{|p| p.path =~ /^CHANGELOG\./ }
            gem_file_list += root.entries.select{|p| p.path =~ /^README\./ }
            gem_file_list += root.entries.select{|p| p.path =~ /^CODE_OF_CONDUCT\./ }
          else
            debugger
            5
          end
        end
      end
    end
  end
end
