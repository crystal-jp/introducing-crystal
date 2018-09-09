# tag::code[]
def shout(x)
  # Int32 と String はどちらも `to_s` メソッドを持っている
  x.to_s.upcase
end

# tag::main[]
foo = ENV["FOO"]? || 10

typeof(foo)        # => (Int32 | String)
typeof(shout(foo)) # => String
# end::main[]
# end::code[]
