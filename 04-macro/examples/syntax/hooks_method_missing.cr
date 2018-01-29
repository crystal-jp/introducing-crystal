# tag::code[]
macro method_missing(call)
  puts "class: {{call.class_name.id}}"
  puts "name: {{call.name.id}}"
  puts "args: {{call.args.size}} arguments"
end

foo
# =>
# name: foo
# args: 0 arguments

bar 1, 'a'
# =>
# name: bar
# args: 2 arguments
# end::code[]
