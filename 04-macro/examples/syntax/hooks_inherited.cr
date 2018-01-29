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

SuperClass.new.type_name # => undefined method 'type_name' for SuperClass
SubClass.new.type_name   # => "SubClass"
# end::code[]
