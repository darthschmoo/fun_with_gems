namespace :fun_with do
  namespace :gems do
    desc "Publish your gem to the world."
    task :publish => :validate do
      puts "Pretending to publish."
    end
  end
end