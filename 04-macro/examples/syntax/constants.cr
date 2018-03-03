CONSTANTS = ["foo", "bar", "baz"]

{% for value in CONSTANTS %}
  puts {{value}}
{% end %}
# output:
# foo
# bar
# baz
