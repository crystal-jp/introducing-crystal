# tag::file[]
# `42` を `yield` するメソッド
def yield_42
  yield 42
end

# tag::main[]
yield_42 { |x| x.to_s.size } # => 2
# ↑を次のように書き直せる
yield_42 &.to_s.size # => 2
# end::main[]
# end::file[]
