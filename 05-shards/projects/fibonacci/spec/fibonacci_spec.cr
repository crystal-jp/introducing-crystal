require "./spec_helper"

describe Fibonacci do
  describe ".number(n : Int)" do

    # n が 1 〜 5 のフィボナッチ数を正しく返してくれる
    it "returns first 5 fibonacci numbers correctly." do
      Fibonacci.number(1).should eq BigInt.new(1)
      Fibonacci.number(2).should eq BigInt.new(1)
      Fibonacci.number(3).should eq BigInt.new(2)
      Fibonacci.number(4).should eq BigInt.new(3)
      Fibonacci.number(5).should eq BigInt.new(5)
    end

    # n が -1 〜 -4 のフィボナッチ数5つを正しく返してくれる
    it "returns first 5 negative fibonacci numbers correctly." do
      Fibonacci.number(-1).should eq BigInt.new(1)
      Fibonacci.number(-2).should eq BigInt.new(-1)
      Fibonacci.number(-3).should eq BigInt.new(2)
      Fibonacci.number(-4).should eq BigInt.new(-3)
      Fibonacci.number(-5).should eq BigInt.new(5)
    end

    # 非常に大きなフィボナッチ数を正しく返してくれる
    it "returns very large fibonacci number correctly." do
      Fibonacci.number(200).should eq BigInt.new("280571172992510140037611932413038677189525")
      Fibonacci.number(-200).should eq BigInt.new("-280571172992510140037611932413038677189525")
    end
  end
end
