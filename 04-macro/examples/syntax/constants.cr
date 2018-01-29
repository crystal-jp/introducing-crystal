# tag::code[]
CONSTANTS = ["foo", "bar", "baz"]

{% for value in CONSTANTS %}
  puts {{value}}
{% end %}
# end::code[]
