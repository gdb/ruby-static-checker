Ruby-static-checker
===================

Ruby-static-checker is, well, a static analysis tool for
Ruby. Ruby-static-checker's goal is to provide a simple set of sanity
checks for existing codebases without requiring any additional
work. This means you should be able to, without modifying your
application, run

```shell
ruby-static-checker /path/to/mainfile.rb
```

And have the static-checker Just Work.

Note that we don't actually completely achieve this
goal. Ruby-static-checker does require your codebase to load all
required code but not execute the program if loaded as a library (use
something like "main if $0 == __FILE__" to get this property). You
can't have everything.

What does it do?
----------------

At the moment, ruby-static-checker searches for name errors in your
code. I've found that name errors (whether due to typoing a variable
or forgetting to update a usage of some class name) are my most common
bug in Ruby, and so I decided to make this ruby-static-checker's first
task.

Ruby-static-checker can find bugs like in the following (contrived) example:

```ruby
class A
  def foo
    baz = 1
    # Whoops, typod 'baz'!
    puts bas
  end
end
```

The current implementation is very barebones. It does have some false
positives (and given the dynamic nature of Ruby, there's basically
always going to be some false rate in either direction) but I've
already used it to find real bugs.

How does it work?
-----------------

Magic!

Well, really, how does it work?
-------------------------------

Ruby-static-checker requires the path you give it, thus loading its
code into memory. Any load-time class and method generation and any
requires are carried out. We then iterate over all newly created
classes, analyzing the ASTs of their methods (using the most excellent
ParseTree library).

This has the benefit that we don't need to statically determine what
the requires graph will look like. Obviously people can always require
more files at runtime, but that's relatively rare so we don't try to
address that case.

Are there any other static analysis tools for Ruby out there?
-------------------------------------------------------------

Yes. Some of the cooler ones are druby, reek, and roodi.

I'd love to contribute. Are patches welcome?
--------------------------------------------

Glad to hear it! Patches are indeed most welcome. Just open a pull
request on Github.
