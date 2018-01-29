# tag::code[]
class User
  def initialize(@name : String, @age : Int32)
  end

  # macroの定義
  macro my_getter(*names)
    {% for name in names %}
      def {{name.id}}
        @{{name.id}}
      end
    {% end %}
  end

  # macroの呼び出し
  my_getter name, age
end

# end::code[]

# tag::main[]
user = User.new("Taro", 30)
user.name # => "Taro"
user.age  # => 30
# end::main[]
