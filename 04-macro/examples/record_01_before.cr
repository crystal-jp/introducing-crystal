# tag::code[]
# Structの定義
struct User
  property name : String
  property age : Int32

  def initialize(@name, @age)
  end
end

# end::code[]

# tag::main[]
user1 = User.new "Taro", 30
user1      # => User(@name="Taro", @age=30)
user1.name # => "Taro"
user1.age  # => 30
# end::main[]
