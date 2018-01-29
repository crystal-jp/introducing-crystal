# tag::code[]
macro conditionals(content)
  {% if content == 1 %}
    "one"
  {% else %}
    {{ content }}
  {% end %}
end

conditionals 1 # => one
conditionals 2 # => 2
# end::code[]
