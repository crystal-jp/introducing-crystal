# tag::file[]
class Foo
  # `@foo` が `Int32` 型だということを宣言する必要があります
  @foo : Int32

  # `@foo` に対するゲッターを定義します
  getter foo

  # getter はマクロです。
  # 他にも setter 、 property があります。

  def initialize(@foo)
  end
end

# tag::main[]
foo = Foo.new 42
foo.foo # => 42
# end::main[]
# end::file[]
