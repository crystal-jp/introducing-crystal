# tag::code[]
macro ast_node_stringify(ast_node)
  {{ ast_node.stringify }}
end

# end::code[]

# tag::main[]
ast_node_stringify 1          # => "1"
ast_node_stringify "string"   # => "\"string\""
ast_node_stringify ["a", "b"] # => "[\"a\", \"b\"]"
ast_node_stringify CONST      # => "CONST"
# end::main[]
