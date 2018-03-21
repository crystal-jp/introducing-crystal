begin
  # 例外を投げるのは `raise` メソッドです
  raise "foo"
rescue e : Exception
  # `Exception` 型の例外が発生した場合に実行される
  e.message # => "foo"
else
  # 例外が発生しなかった場合に実行される
ensure
  # 例外が発生しようがしまいが実行される
end
