arr = [] of Int32

# これはコンパイルできません
# arr.push "foo"
# no overload matches 'Array(Int32)#push' with type String

# これならできます
arr.push 42
arr # => [42]
