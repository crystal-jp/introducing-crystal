# tag::code[]
macro iteration(names)
  {% for key, value in names %}
    def {{key.id}}
      {{value}}
    end
  {% end %}
end

iteration({foo: "FOO", bar: "BAR", baz: "BAZ"})

foo # => "FOO"
bar # => "BAR"
baz # => "BAZ"
# end::code[]
