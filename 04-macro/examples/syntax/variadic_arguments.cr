# tag::code[]
macro variadic_arguments(*names)
  {% for name, index in names %}
    def {{name.id}}
      {{index}}
    end
  {% end %}
end

variadic_arguments foo, bar, baz

# end::code[]

# tag::main[]
foo # => 0
bar # => 1
baz # => 2
# end::main[]
