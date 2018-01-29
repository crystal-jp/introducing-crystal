# tag::code[]
macro ast_node_id(ast_node)
  def {{ ast_node.id }}
    "content"
  end
end

ast_node_id foo   # => "content"
ast_node_id "bar" # => "content"
ast_node_id :baz  # => "content"
# end::code[]
