# tag::code[]
# トップレベルで定義されたマクロは、どこからでも参照可能
macro my_macro
  "expanded my macro!!!"
end

# end::code[]

# tag::main[]
my_macro # => "expanded my macro!!!"
# end::main[]
