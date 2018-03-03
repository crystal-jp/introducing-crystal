# tag::code[]
macro iteration(names)
  {% for name, index in names %}
    def {{name}}
      {{index}}
    end
  {% end %}
end

iteration [foo, bar, baz]

# end::code[]

# tag::main[]
foo # => 0
bar # => 1
baz # => 2
# end::main[]
