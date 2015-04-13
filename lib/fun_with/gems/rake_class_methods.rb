module FunWith
  module Gems
    module RakeClassMethods
      def setup this_gem, rake_main
        set_gem        this_gem
        set_rake_main  rake_main
        run_bundler_setup
        load_tasks
      end
      
      def set_gem g
        @gem = g
      end
      
      def set_rake_main m
        @rake_main = m
      end
      
      def run_bundler_setup
        jeweler_requirements
        rake_requirements
        
        begin
          Bundler.setup(:default, :development)
        rescue Bundler::BundlerError => e
          $stderr.puts e.message
          $stderr.puts "Run `bundle install` to install missing gems"
          exit e.status_code
        end
      end
      
      def specification &block
        Jeweler::Tasks.new do |gem|
          yield gem
        end
      end
      
      def setup_gem_boilerplate
        run_in_rakefile do
          Jeweler::RubygemsDotOrgTasks.new

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
      
      def jeweler_requirements
        require 'rake'
        require 'jeweler'
      end
      
      def rake_requirements
        require 'rdoc/task'
        require 'rake/testtask'
      end
      
      def run_in_rakefile &block
        if @rake_main.nil?
          raise "Did you forget the line FunWith::Gems::Rakefile.set_rake_main by any chance?"
        elsif ! block_given?
          raise ArgumentError.new("Block must be given")
        else
          @rake_main.instance_eval &block
        end
      end
      
      def load_tasks
        load_internal_tasks
        load_external_tasks
      end
      
      def load_internal_tasks
        load_tasks_from @gem.root( "tasks" )
      end
      
      def load_external_tasks
        loat_tasks_from @gem.root( "lib", "tasks" )
      end
      
      def load_tasks_from dir
        dir.glob do |file|
          if file.file? && ( file.ext == "rb" || file.ext == "rake" )
            puts "Adding tasks from #{file}"
            run_in_rakefile do
              load file
            end
          end
        end
      end
    end
  end
end

