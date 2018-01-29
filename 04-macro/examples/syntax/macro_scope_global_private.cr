# tag::code[]
# private を付けた場合は、同一ファイル内で参照可能
private macro my_macro
  def my_method; end
end

my_macro
# end::code[]
