# tag::file[]
# `Foo` クラスを定義
class Foo
  # `foo` メソッドを定義
  def foo
    42
  end
end

# `Foo` を継承した `Bar` クラスを定義
class Bar < Foo
  # `bar` メソッドを定義
  def bar
    # `return` で明示的に返り値を指定することもできる
    return "bar"
  end
end

# tag::main[]
foo = Foo.new # => #<Foo:0x103ce3ff0>
foo.foo       # => 42

bar = Bar.new # => #<Bar:0x1067ddfe0>
# `Bar` は `Foo` を継承しているので `foo` も呼び出せる
bar.foo # => 42
# end::main[]
# end::file[]
