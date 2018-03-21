# 変数は `=` で代入します
foo = 42
foo # => 42

# 代入してない変数を参照するとコンパイルエラー
# baz
# undefined local variable or method 'baz'

# 複数の変数に同時に代入することもできます
foo, bar = 42, "foo"
foo # => 42
bar # => "foo"

# タプルを複数の変数に代入することもできます
tuple = {42, "foo"}
foo, bar = tuple
foo # => 42
bar # => "foo"
