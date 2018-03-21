# 三項演算子の結果の型は、両方の結果の型のユニオンになります
foo = true ? 42 : "foo"
foo         # => 42
typeof(foo) # => (Int32 | String)

if foo.is_a?(Int32)
  # この `if` の中では `foo` の型は `Int32` になります
  typeof(foo) # => Int32
end

bar = true ? 42 : nil
typeof(bar) # => (Int32 | Nil)

# `Nil` を含むような型の場合、
# 単純に変数を条件にするだけでチェックできます
if bar
  # ここは `bar` が `nil` 以外の値のときに実行されます
  typeof(bar) # => Int32
end
