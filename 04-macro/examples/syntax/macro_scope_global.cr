# tag::code[]
# global で定義された Macro は、どこからでも参照可能
macro my_macro
  "expanded my macro!!!"
end

# end::code[]

# tag::main[]
my_macro # => "expanded my macro!!!"
# end::main[]
