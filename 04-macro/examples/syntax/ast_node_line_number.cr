# tag::code[]
macro ast_node_line_number(ast_node)
  {{ ast_node.line_number }}
end

# ... 他のコードが並ぶ

# end::code[]

# tag::main[]
ast_node_line_number 1        # => 12
ast_node_line_number "string" # => 13
# end::main[]
