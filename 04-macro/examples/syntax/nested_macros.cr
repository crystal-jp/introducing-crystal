# tag::code[]
macro define_macros(*names)
  {% for name in names %}
    macro greeting_for_{{name.id}}(greeting)
      \{% if greeting == "hola" %}
        "¡hola {{name.id}}!"
      \{% else %}
        "\{{greeting.id}} {{name.id}}"
      \{% end %}
    end
  {% end %}
end

# This generates:
#
#     macro greeting_for_alice(greeting)
#       {% if greeting == "hola" %}
#         "¡hola alice!"
#       {% else %}
#         "{{greeting.id}} alice"
#       {% end %}
#     end
#     macro greeting_for_bob(greeting)
#       {% if greeting == "hola" %}
#         "¡hola bob!"
#       {% else %}
#         "{{greeting.id}} bob"
#       {% end %}
#     end
define_macros alice, bob

greeting_for_alice "hello"  #=> "hello alice"
greeting_for_bob "hallo"    #=> "hallo bob"
greeting_for_alice "hej"    #=> "hej alice"
greeting_for_bob "hola"     #=> "¡hola bob!"
# end::code[]
