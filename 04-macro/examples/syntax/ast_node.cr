# tag::code[]
# 引数のclass_nameを表示させるmacro
macro ast_node_class_name(ast_node)
  {{ ast_node.class_name }}
end

# end::code[]

# tag::main[]
ast_node_class_name(1)              # => "NumberLiteral"
ast_node_class_name("string")       # => "StringLiteral"
ast_node_class_name(ast)            # => "Call"
ast_node_class_name(["a", "b"])     # => "ArrayLiteral"
ast_node_class_name({key: "value"}) # => "NamedTupleLiteral"
# end::main[]
