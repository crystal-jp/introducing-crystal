# tag::code[]
module MacroScope
  macro my_macro
    def my_method; end
  end

  # module 内で参照可能
  my_macro

  # モジュールメソッド内で参照可能
  def instance_method
    my_macro
  end

  # モジュールクラスメソッド内で参照可能
  def self.class_method
    my_macro
  end
end

# モジュールメソッドと同じ syntax で参照可能
MacroScope.my_macro

# end::code[]
