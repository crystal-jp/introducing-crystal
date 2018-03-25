# tag::code[]
class MacroScope
  macro my_macro
    "expanded my macro!!"
  end

  # class 内で参照可能
  CONSTANT = my_macro

  # インスタンスメソッド内で参照可能
  def instance_method
    my_macro
  end

  # クラスメソッド内で参照可能
  def self.class_method
    my_macro
  end
end

# tag::main[]
# クラスメソッドと同じ syntax で参照可能
MacroScope.my_macro # => "expanded my macro!!"

# インスタンスメソッドとしては参照できない
# MacroScope.new.my_macro は undefined method になる
# end::code[]

MacroScope::CONSTANT           # => "expanded my macro!!"
MacroScope.new.instance_method # => "expanded my macro!!"
MacroScope.class_method        # => "expanded my macro!!"
# end::main[]
