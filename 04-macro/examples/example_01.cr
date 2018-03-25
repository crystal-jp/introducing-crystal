# tag::code[]
macro my_macro(method_name, content)
  def {{method_name}} # <1>
    {{content}}
  end
end

my_macro(my_method, "hoge") # <2>

# end::code[]

# tag::main[]
my_method # <3>
# => "hoge"
# end::main[]
