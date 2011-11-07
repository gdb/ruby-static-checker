Ruby-static-checker
===================

It drives me crazy that the my most common bug in Ruby is a name
error. Maybe I typo a variable, or maybe I rename a class name in
every location except for one, or maybe a cosmic ray flips a bit in my
source before I commit. These are all mistakes that would be caught in
a more static language like C or Java.

But there's no inherent reason we can't have a static checker to catch
these sorts of bugs. Because Ruby is so dynamic, it is impossible to
write a checker with 100% accuracy (you'll always be able to write
byzantine programs that do crazy method redefinitions at runtime). But
given a reasonable codebase, you should be able to write a tool to
find name errors with a reasonable amount of certainty.

Ruby-static-checker is, well, a static analysis tool for
Ruby. Ruby-static-checker's goal is to provide a simple set of sanity
checks (starting with name error detection) for existing codebases
without requiring any additional programmer work. This means you
should be able to, without modifying your application, run

```shell
ruby-static-checker /path/to/mainfile.rb
```

And have the static analysis Just Work.

Note that we don't actually completely achieve this
goal. Ruby-static-checker does require your codebase to load all
required code but not execute the program if loaded as a library (use
something like "main if $0 == __FILE__" to get this property). You
can't have everything.

What does it do?
----------------

At the moment, ruby-static-checker just searches for name errors in
your code. It's possible I'll make it do other things in the future.

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

The output of this should be:

```shell
gdb@fire-hazard:~$ ruby-static-checker /path/to/a.rb
Possible name error while calling A<instance>.bas
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

Limitations
-----------

Tested on Ruby 1.8. I added handling of AST nodes as I encountered
them in actual code, so it's likely there are some more esoteric nodes
that I missed.

I'd love to contribute. Are patches welcome?
--------------------------------------------

Glad to hear it! Patches are indeed most welcome. Just open a pull
request on Github.
