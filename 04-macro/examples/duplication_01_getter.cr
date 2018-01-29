# tag::code[]
class User
  def initialize(@name : String, @age : Int32)
  end

  getter name, age
end

# end::code[]

# tag::main[]
user = User.new("Taro", 30)
user.name # => "Taro"
user.age  # => 30
# end::main[]
