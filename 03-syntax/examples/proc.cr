# `Proc` を作ります
proc = ->(foo : Int32, bar : String) { foo + bar.size }

# `Proc` を呼び出します
proc.call(42, "bar") # => 45
