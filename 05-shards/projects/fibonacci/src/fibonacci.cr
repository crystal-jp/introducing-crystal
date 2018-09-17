require "big"

# Retuen fibonacci number.
module Fibonacci
  VERSION = "0.1.0"

  @@numbers = [BigInt.new(0), BigInt.new(1)]

  def self.number(n : Int)
    negative = (n < 0)
    even = n.even?
    n = n.abs
    while @@numbers.size < n + 1
      @@numbers << @@numbers[-1] + @@numbers[-2]
    end
    if negative && even
      -@@numbers[n]
    else
      @@numbers[n]
    end
  end
end
