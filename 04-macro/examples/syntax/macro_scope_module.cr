# tag::code[]
module MacroScope
  macro my_macro
    "expanded my macro!!"
  end

  # モジュール内で参照可能
  CONSTANT = my_macro

  # モジュールメソッド内で参照可能
  def instance_method
    my_macro
  end

  # モジュールクラスメソッド内で参照可能
  def self.class_method
    my_macro
  end
end

# モジュールを include したクラスを用意する
class MyClass
  include MacroScope
end

# end::code[]

# tag::main[]
# モジュールクラスメソッドと同じ syntax で参照可能
MacroScope.my_macro     # => "expanded my macro!!"
MacroScope::CONSTANT    # => "expanded my macro!!"
MacroScope.class_method # => "expanded my macro!!"

MyClass.my_macro # => "expanded my macro!!"

# インスタンスメソッドとしては参照できない
# MacroScope.new.my_macro は undefined method になる
# end::code[]

MyClass::CONSTANT           # => "expanded my macro!!"
MyClass.new.instance_method # => "expanded my macro!!"
# end::main[]
