# tag::code[]
# global で定義された Macro は、どこからでも参照可能
macro my_macro
  def my_method; end
end

my_macro
# end::code[]
