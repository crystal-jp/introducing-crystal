# tag::code[]
macro splat(*args)
  puts {{*args}} # => puts 1,2,3
end

splat 1, 2, 3
# end::code[]
