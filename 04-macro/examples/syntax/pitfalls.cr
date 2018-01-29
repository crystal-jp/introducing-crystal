# tag::code[]
var = "pitfalls"

case var
  {% for klass in [Int32, String] %}
    when {{ klass.id }} then "#{var} is {{ klass }}"
  {% end %}
end
# end::code[]
