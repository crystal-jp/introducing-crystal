# tag::def[]
# 割り算をするメソッド
def div(left, right)
  left / right
end

# 引数名を空白で二つ並べると、
# 一つ目が名前付き引数用の名前、二つ目が内部で使う引数の名前になる
def even(if cond)
  cond
end

# end::def[]

# tag::main[]
# 名前付き引数を指定
div(left: 1.0, right: 2.0) # => 0.5
# 順番を逆にして指定
div(right: 2.0, left: 1.0) # => 0.5

# `cond` ではなく `if` を名前付き引数に指定する
even if: true # => true
# end::main[]
