# tag::compileonly[]
# end::compileonly[]
# tag::file[]
require "http/server"

class InterruptTestFirst
  include HTTP::Handler

  def call(context)
    response = call_next(context)
    puts "aa"
    response
  end
end

class InterruptTestSecond
  include HTTP::Handler

  def call(context)
    response = call_next(context)
    puts "bb"
    response
  end
end

server = HTTP::Server.new([InterruptTestFirst.new, InterruptTestSecond.new]) do |context|
  context.response.content_type = "text/plain"
  context.response.print "Hello world"
end

puts "Listening on http://0.0.0.0:8080"
server.listen(8080)
# end::file[]
