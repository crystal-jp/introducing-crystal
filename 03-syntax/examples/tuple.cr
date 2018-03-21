# タプル
tuple = {42, "foo"}
typeof(tuple) # => Tuple(Int32, String)

# タプルは配列と違い要素毎に型を持っています
typeof(tuple[0]) # => Int32
typeof(tuple[1]) # => String

# 名前付きタプル
named = {
  foo: 42,
  bar: "bar",
}
typeof(named) # => NamedTuple(foo: Int32, bar: String)

# 名前付きタプルはハッシュと違い要素毎に型を持っています
typeof(named[:foo]) # => Int32
typeof(named[:bar]) # => String
