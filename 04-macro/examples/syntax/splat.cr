macro splat
  p "Splatting a array"
  {% array = [1, 2, 3] %}
  p {{*array}}

  p "Splatting a tuple"
  {% tuple = {4, 5, 6} %}
  p {{*tuple}}

  # p "Double Splatting a hash"
  # {% hash = {"a" => 1, "b" => 2} %}
  # p {{**hash}}
  # ------------
  # Syntax error in expanded macro: splat:11: unexpected token: =>
  #
  # p "a" => 1, "b" => 2
  #       ^

  p "Double Splatting a named tuple"
  {% named_tuple = {"c": 3, "d": 4} %}
  p {{**named_tuple}}
end

splat
# output:
# "Splatting a array"
# 1
# 2
# 3
# "Splatting a tuple"
# 4
# 5
# 6
# "Double Splatting a named tuple"
# {c: 3, d: 4}
