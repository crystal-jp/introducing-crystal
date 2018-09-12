# tag::def[]
# 可変長引数・名前付き引数の余りを受け取ってその型を返すメソッド
def vararg_type(*tuple, **named_tuple)
  [typeof(tuple), typeof(named_tuple)]
end

# end::def[]

# tag::main[]
# 可変長引数の場合
vararg_type(42, "str")
# => [Tuple(Int32, String), NamedTuple()]

# 名前付き引数の場合
vararg_type(foo: 42, bar: "str")
# => [Tuple(), NamedTuple(foo: Int32, bar: String)]

# splat 展開
tuple = {42, "str"} # タプルのリテラルは配列の `{ }` 版
# 名前付きタプルはハッシュの `:` 区切り版
named_tuple = {
  foo: 42,
  bar: "str",
}
vararg_type(*tuple, **named_tuple)
# => [Tuple(Int32, String), NamedTuple(foo: Int32, bar: String)]
# end::main[]
