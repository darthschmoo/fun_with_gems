namespace :fun_with do
  namespace :gems do
    desc "Validate your gem (passes tests, has FunWith::Gems functionality)."
    task :validate do
      g = FunWith::Gems::Rakefile.get_gem
    
      if g.is_fun_gem?
        if g.valid_gem?
          puts "#{g} passed validation."
          
          if g.passes_tests?
            puts "#{g} passed its test suite"
            true
          else
            puts "#{g} failed its test suite"
            false
          end
        else
          puts "#{g} failed validation"
          false
        end
      else
        puts "#{g} is not a FunWith::Gems gem."
        false
      end
    end
  end
end