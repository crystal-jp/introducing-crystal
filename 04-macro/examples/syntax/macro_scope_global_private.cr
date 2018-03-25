# tag::code[]
# private を付けた場合は、同一ファイル内で参照可能
private macro my_macro
  "expanded my macro!!!"
end

# end::code[]

# tag::main[]
my_macro # => "expanded my macro!!!"
# end::main[]
