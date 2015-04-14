namespace :empty do
  desc "Fake task"
  
  task :environment do
    require File.join( File.dirname(__FILE__), "..", "..", "lib", "fun_with_gems" )
  end
end
