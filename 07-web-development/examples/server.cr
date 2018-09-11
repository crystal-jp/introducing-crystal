# tag::compileonly[]
# end::compileonly[]
# tag::file[]
require "http/server"

server = HTTP::Server.new do |context|
  context.response.content_type = "text/plain"
  context.response.print "Hello world"
end

puts "Listening on http://0.0.0.0:8080"
server.listen(8080)
# end::file[]
