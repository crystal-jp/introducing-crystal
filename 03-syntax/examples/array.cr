# 数値の配列
typeof([1, 2, 3]) # => Array(Int32)

# 文字列の配列
typeof(["foo", "bar"]) # => Array(String)

# `%w` 形式も使えます
%w(foo bar)         # => ["foo", "bar"]
typeof(%w(foo bar)) # => Array(String)

# 数値と文字列の配列
arr = ["foo", 42]
typeof(arr) # => Array(Int32 | String)

# 配列の型が `Array(Int32 | String)` なので
# 要素の型は `Int32 | String` になります
typeof(arr[0]) # => (Int32 | String)
typeof(arr[1]) # => (Int32 | String)
