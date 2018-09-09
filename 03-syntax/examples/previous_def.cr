# tag::file[]
# 最初に定義したもの
def foo(x : Int32)
  1 + x
end

# 次に定義したもの
# こちらが呼ばれる
def foo(x : Int32)
  previous_def + 2 # ここの `previous_def` で上の `foo` が呼ばれる
end

# tag::main[]
foo(3) # => 6
# end::main[]
# end::file[]
