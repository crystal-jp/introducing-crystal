# tag::code[]
{% for name, index in ["foo", "bar", "baz"] %}
  def {{name.id}}
    {{index}}
  end
{% end %}

foo # => 0
bar # => 1
baz # => 2
# end::code[]
