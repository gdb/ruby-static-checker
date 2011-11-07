Gem::Specification.new do |s|
  s.name        = 'ruby-static-checker'
  s.version     = '0.0.1'
  s.authors     = ["Greg Brockman"]
  s.email       = ["gdb@gregbrockman.com"]
  s.homepage    = 'https://github.com/gdb/ruby-static-checker'
  s.summary     = %q{A static checker for Ruby}
  s.description = %q{Ruby-static-checker is, well, a static analysis tool for
Ruby. Ruby-static-checker's goal is to provide a simple set of sanity
checks (starting with name error detection) for existing codebases
without requiring any additional programmer work. This means you
should be able to, without modifying your application, run

ruby-static-checker /path/to/mainfile.rb

And have the static analysis Just Work.}

  s.rubyforge_project = "ruby-static-checker"

  s.files         = `git ls-files`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }

  s.add_runtime_dependency 'ParseTree'
end
