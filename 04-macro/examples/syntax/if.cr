# tag::code[]
macro conditionals(content)
  {% if content == 1 %}
    "one"
  {% else %}
    {{ content }}
  {% end %}
end

# end::code[]

# tag::main[]
conditionals 1 # => "one"
conditionals 2 # => 2
# end::main[]
