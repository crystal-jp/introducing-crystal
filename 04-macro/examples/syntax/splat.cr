macro splat(*args)
  print {{*args}}, "\n"
end

splat 1, 2, 3
# output:
# 123
