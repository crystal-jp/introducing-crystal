# tag::code[]
ret = ""

{% begin %}
  var = "pitfalls"

  ret = case var
    {% for klass in [Int32, String] %}
      when {{ klass.id }} then "#{var} is {{ klass }}"
    {% end %}
  end
{% end %}

# end::code[]

# tag::main[]
ret # => "pitfalls is String"
# end::main[]
