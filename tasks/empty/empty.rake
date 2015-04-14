namespace :empty do
  desc "Fake task"
  task( :empty  => :environment ) do
    puts "Fake task!"
  end
end
