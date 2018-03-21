# `1` から `100` までの範囲
1..100
typeof(1..100) # => Range(Int32, Int32)

1...100
typeof(1...100) # => Range(Int32, Int32)

# `..` は終わりの値を含みます
(1..100).includes?(100) # => true

# `...` は終わりの値を含ません
(1...100).includes?(100) # => false
