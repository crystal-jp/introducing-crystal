# tag::code[]
macro ast_node_array_literal(ast_node)
  {% puts ast_node.map(&.capitalize).join("::") %}
end

ast_node_array_literal ["apple", "banana"] # => "Apple::Banana"
# end::code[]
