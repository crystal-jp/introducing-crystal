# tag::code[]
macro ast_node_id(ast_node)
  def {{ ast_node.id }}
    "content"
  end
end

ast_node_id foo
ast_node_id "bar"
ast_node_id :baz

# end::code[]

# tag::main[]
foo # => "content"
bar # => "content"
baz # => "content"
# end::main[]
