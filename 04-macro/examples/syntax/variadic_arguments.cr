# tag::code[]
macro variadic_arguments(*names)
  {% for name, index in names %}
    def {{name.id}}
      {{index}}
    end
  {% end %}
end

variadic_arguments foo, bar, baz

foo # => 0
bar # => 1
baz # => 2
# end::code[]
