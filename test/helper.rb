require 'fun_with_testing'
require 'fun_with_gems'

unless defined?(FunWith::Gems)
  puts "FunWith::Gems not defined"
end

# I don't recall why this was needed
FunWith::Gems.make_gem_fun( FunWith::Testing, :require => false )

class FunWith::Gems::TestCase < FunWith::Testing::TestCase
  # include: true option means that, within the test suite, the gem's namespace
  # is included, so classes within that namespace can be referenced without using
  # the namespace.
  self.make_testing_fun( FunWith::Gems, include: true )
end
