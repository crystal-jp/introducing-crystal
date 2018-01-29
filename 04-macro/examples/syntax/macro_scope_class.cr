# tag::code[]
class MacroScope
  macro my_macro
    def my_method; end
  end

  # class 内で参照可能
  my_macro

  # インスタンスメソッド内で参照可能
  def instance_method
    my_macro
  end

  # クラスメソッド内で参照可能
  def self.class_method
    my_macro
  end
end

# クラスメソッドと同じ syntax で参照可能
MacroScope.my_macro

# インスタンスメソッドとしては参照できない
MacroScope.new.my_macro # => undefined method

# end::code[]
