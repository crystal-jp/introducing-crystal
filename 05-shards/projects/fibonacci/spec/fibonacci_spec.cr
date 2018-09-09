require "./spec_helper"

describe Fibonacci do
  describe ".number(n : Int)" do
    it "returns fibonacci numbers correctly." do
      Fibonacci.number(5).should eq BigInt.new(5)
      Fibonacci.number(10).should eq BigInt.new(55)
    end

    it "returns negative fibonacci numbers correctly." do
      Fibonacci.number(-5).should eq BigInt.new(5)
      Fibonacci.number(-10).should eq BigInt.new(-55)
    end

    it "returns very large fibonacci number correctly." do
      Fibonacci.number(200).should eq BigInt.new("280571172992510140037611932413038677189525")
      Fibonacci.number(-200).should eq BigInt.new("-280571172992510140037611932413038677189525")
    end
  end
end
