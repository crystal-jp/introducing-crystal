# tag::file[]
class Foo
  # `initialize` の引数にインスタンス変数が指定されているとき
  # 型指定かデフォルト引数があればインスタンス変数の型は
  # 推論されます
  # この場合は `@foo` が `Int32`、 `@bar` が `String` 型になります
  def initialize(@foo : Int32, @bar = "foo")
  end

  getter foo, bar

  # `baz` メソッドを 0引数、 `Int32` と `String` に対して定義

  def baz
    0
  end

  def baz(a : Int32)
    :int32
  end

  def baz(a : String)
    :string
  end
end

# tag::main[]
foo = Foo.new(42) # デフォルト引数は省略できます
foo.bar           # => "foo"
# オーバロードしたメソッドは引数に応じて適切なものが呼び出されます
foo.baz        # => 0
foo.baz(42)    # => :int32
foo.baz("baz") # => :string
# end::main[]
# end::file[]
