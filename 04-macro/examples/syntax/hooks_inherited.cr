# tag::code[]
class SuperClass
  macro inherited
    def type_name
      {{ @type.name.stringify }}
    end
  end
end

class SubClass < SuperClass
end

# end::code[]

# tag::main[]
# SuperClass.new.type_name は undefined method 'type_name' for SuperClass となる
SubClass.new.type_name # => "SubClass"
# end::main[]
