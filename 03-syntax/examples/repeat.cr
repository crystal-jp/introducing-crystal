foo = 2

# `while`
# 条件が真である間繰り返します
i, j = 0, 0
while i <= foo
  i, j = i + 1, j + i
end
j # => 3

# `until`
# 条件が偽である間繰り返す
# == 条件が真になるまで繰り返す
i, j = 0, 0
until i > foo
  i, j = i + 1, j + i
end
j # => 3
