# tag::code[]
macro fresh_vars_sample
  %hoge{"a"}      = 0
  %hoge{1}        = 1
  %hoge{["b", 2]} = 2

  {% for key in ["a", 1, ["b", 2]] %}
    puts %hoge{key}
  {% end %}
end

fresh_vars_sample
# end::code[]
