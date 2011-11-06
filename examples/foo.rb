class A
  def foo
    a = 1
    a
  end

  def bar
    foo
  end

  def car
    c
    c = 1
  end
end

module B
  def foo
    a
  end

  def self.bar
    a
  end
end
