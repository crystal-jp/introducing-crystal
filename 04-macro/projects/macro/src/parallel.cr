require "timecop"

module Parallel
  def self.run(time)
    io = IO::Memory.new
    ret1, ret2, ret3 = ["", "", ""]
    Timecop.travel(time) do
      # tag::code[]

      # １秒後に、文字列を出力し文字列を返すlambda
      job1 = ->{
        sleep 1
        io.puts "job1  : #{Time.now.to_s("%F %T")}"
        "return job1"
      }

      # ２秒後に、文字列を出力し文字列を返すlambda
      job2 = ->{
        sleep 2
        io.puts "job2  : #{Time.now.to_s("%F %T")}"
        "return job2"
      }

      # ３秒後に、文字列を出力し文字列を返すlambda
      job3 = ->{
        sleep 3
        io.puts "job3  : #{Time.now.to_s("%F %T")}"
        "return job3"
      }

      # 動かしてみる
      io.puts "start : #{Time.now.to_s("%F %T")}"
      ret1, ret2, ret3 = parallel job1.call, job2.call, job3.call
      # end::code[]
    end
    return io, ret1, ret2, ret3
  end
end

io, ret1, ret2, ret3 = Parallel.run(Time.new(2018, 1, 1, 0, 0, 0))

# tag::main[]
io.to_s
# =>
# start : 2018-01-01 00:00:00
# job1  : 2018-01-01 00:00:01
# job2  : 2018-01-01 00:00:02
# job3  : 2018-01-01 00:00:03

ret1 # => return job1
ret2 # => return job2
ret3 # => return job3
# end::main[]
