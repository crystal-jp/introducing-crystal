# tag::file[]
class Foo
  # 引数にインスタンス変数を指定すると、その変数に代入される。
  # 加えて、引数の型やデフォルト引数を指定すると、インスタンス変数の型が
  # その型に推論される。
  def initialize(@foo : Int32, @bar = "bar")
    # こういう単純な代入の場合もインスタンス変数の型は推論される。
    @baz = Array(Int32).new
  end

  # インスタンス変数に対するゲッターメソッドを定義
  getter foo, bar, baz
end

# tag::main[]
foo = Foo.new 42

typeof(foo.foo) # => Int32
typeof(foo.bar) # => String
typeof(foo.baz) # => Array(Int32)
# end::main[]
# end::file[]
