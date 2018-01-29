# tag::code[]
macro ast_node_line_number(ast_node)
  {% puts ast_node.line_number %}
end

ast_node_line_number 1        # => 5
ast_node_line_number "string" # => 6
# end::code[]
