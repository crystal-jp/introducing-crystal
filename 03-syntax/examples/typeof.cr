# 文字列リテラルの型は `String`
typeof("foo") # => String

# 引数の式は実行されない
typeof(puts "hello") # => Nil
# hello とは出力されない
