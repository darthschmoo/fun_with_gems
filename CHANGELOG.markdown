CHANGELOG
=========

v0.0.7
------

Separating some functionality into other gems. Or not?  I think this is an old comment.  The idea was to break off a bunch of gems and have FWG bring them in as dependencies.  But I never got around to it.  Requirements gem might be a good candidate.  

Maybe keep the gem monolithic, but figure out how to let users do `require "fun_with_gems/inclusionizer"` or something.

Consider also moving the testing/assertions into the test/lib directory for new gems, since only the test suite needs to see them.

v0.0.6
------

* Simpler Rakefile, using expectations about which folders/files should be included.  `add_specification_files()`
* Added auto-loading of Gem::Name::CoreExtension modules to base classes.
* FunWith::Gems::Inclusionizer provides a useful, opinionated way to organize your code for mixins.

v0.0.5
------

Moved all "test the gem" code to a separate `fun_with_gemdev` gem.

v0.0.3
------

Moved some of the standard Rakefile boilerplate into FunWith::Gems::Rakefile.  Goal is to simplify rakefiles, add a set of fun_with:gems: rake tasks, etc.
Removed Mechanic (seemed pretty useless)


v0.0.2
------

Dependent on `fun_with_testing` and `fun_with_files`, even `fun_with_version_strings`.  It's all very silly, really.


0.0.1
-----




0.0.0
-----

No changes!