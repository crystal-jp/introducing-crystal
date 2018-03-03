# tag::code[]
{% for name, index in ["foo", "bar", "baz"] %}
  def {{name.id}}
    {{index}}
  end
{% end %}

# end::code[]

# tag::main[]
foo # => 0
bar # => 1
baz # => 2
# end::main[]
