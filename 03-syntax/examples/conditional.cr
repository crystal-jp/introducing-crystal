# `if`
foo = 2
if foo <= 1 # `foo` が `1` 以下のときに実行
  :if
elsif foo == 2 # `foo` が `2` のときに実行
  :elsif
else # `foo` が `3` 以上のときに実行
  :else
end
# => :elsif

# `unless`
# `unless ~` は `if !(~)` に等しいです
# （条件部分が偽のときに実行される）
unless foo == 1 # `foo` が `1` ではないときに実行
  :unless
else # それ以外のときに実行
  :else
end
# => :unless

# `case`
case foo
when    1 then 1
when 2, 3 then 2..3
else           :other
end
# => 2..3

# 三項演算子も使えます
foo == 1 ? 2 : 3 # => 3

# 後置 `if`、後置 `unless` もあります
bar = 42 if foo == 2
bar # => 42

baz = 24 unless foo == 1
baz # => 24
