# SAMPLE OUTPUT:
# gdb@fire-hazard:~$ ruby-static-checker ./foo.rb
# Possible name error while calling B<instance>.a
# Possible name error while calling B<instance>.baz
# Possible name error while calling B.a
# Possible name error while calling A<instance>.c

class A
  def foo
    a = 1
    a
  end

  def bar
    foo
    private_methods
  end

  def car
    c
    c = 1
  end
end

module B
  def foo
    a
    instance_bar
  end

  def instance_bar
    baz
    foo
  end

  def self.bar
    a
  end
end
