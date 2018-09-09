# tag::code[]
struct User
  def initialize(@name : String, @age : Int32)
  end

  # 同値性比較のメソッドを定義
  def_equals @name, @age
end

# end::code[]

# tag::main[]
user1 = User.new "Taro", 30
user2 = User.new "Taro", 30
user1 == user2 # => true
# end::main[]
