macro method_missing(call)
  puts "name: {{call.name.id}}"
  puts "args: {{call.args.size}} arguments"
end

foo
# output:
# name: foo
# args: 0 arguments

bar 1, 'a'
# output:
# name: bar
# args: 2 arguments
