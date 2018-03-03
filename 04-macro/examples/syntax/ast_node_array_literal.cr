# tag::code[]
macro ast_node_array_literal(ast_node)
  {{ ast_node.map(&.capitalize).join("::") }}
end

# end::code[]

# tag::main[]
ast_node_array_literal ["apple", "banana"] # => "Apple::Banana"
# end::main[]
