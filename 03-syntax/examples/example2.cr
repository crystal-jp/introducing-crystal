# Crystal のプログラム！

# `foo` の引数が `String` の場合のメソッド
def foo(x : String)
  p :string
end

# `foo` の引数が `Int32` （数値）の場合のメソッド
def foo(x : Int32)
  p :int32
end

# 呼び出し時に引数の型によって適切なものが選択される
foo "string"
foo 42

# output:
# :string
# :int32
