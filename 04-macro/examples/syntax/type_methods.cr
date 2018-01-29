# tag::code[]
class MyClass
  def m1
  end

  protected def m2
  end

  private def m3
  end

  def methods_name
    # 定義されているメソッドの名前を返す
    {{ @type.methods.map(&.name.stringify) }}
  end

  def methods_visibility
    # 定義されているメソッドのアクセス修飾子を返す
    {{ @type.methods.map(&.visibility.stringify) }}
  end
end

my_class = MyClass.new
puts my_class.methods_name       # => ["m1", "m2", "m3", "methods_name", "methods_visibility"]
puts my_class.methods_visibility # => [":public", ":protected", ":private", ":public", ":public"]
# end::code[]
