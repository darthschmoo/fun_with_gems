require 'fun_with_testing'
require 'fun_with_gems'

# What exactly does this do?
FunWith::Gems.make_gem_fun( FunWith::Testing, :require => false )

class FunWith::Gems::TestCase < FunWith::Testing::TestCase
  make_testing_fun( FunWith::Gems )
end
