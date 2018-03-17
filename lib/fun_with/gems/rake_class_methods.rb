module FunWith
  module Gems
    module RakeClassMethods
      attr_accessor :gem
      
      def setup this_gem, rake_main
        set_gem        this_gem
        set_rake_main  rake_main
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
      
      def set_rake_main m
        @rake_main = m
      end
      
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
      
      def specification &block
        Juwelier::Tasks.new do |gem|
          yield gem
        end
      end
      
      def setup_gem_boilerplate
        run_in_rakefile do
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
        end
      end
      
      def all_requirements
        run_in_rakefile do
          require 'rake'
          require 'juwelier'
          require 'rdoc/task'
          require 'rake/testtask'
          require 'bundler'
        end
      end
      
      def run_in_rakefile &block
        if @rake_main.nil?
          raise "Did you forget the line FunWith::Gems::Rakefile.set_rake_main by any chance?"
        elsif ! block_given?
          raise ArgumentError.new("Block must be given")
        else
          @rake_main.instance_eval( &block )
        end
      end
      
      def gem_files( *args, &block )
        Dir.glob( File.join( ".", "lib", "**", "*.rb" ) ) +
                    Dir.glob( File.join( ".", "test", "**", "*.*" ) ) +
                    [ "Gemfile",
                      "Rakefile",
                      "LICENSE.txt",
                      "README.rdoc",
                      "VERSION"
                    ]


        
      end
    end
  end
end

