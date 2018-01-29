# tag::code[]
# Structの定義
record User, name : String, age : Int32

# end::code[]

# tag::main[]
user1 = User.new "Taro", 30
user1      # => User(@name="Taro", @age=30)
user1.name # => "Taro"
user1.age  # => 30
# end::main[]
