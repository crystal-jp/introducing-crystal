require "./spec_helper"

describe Parallel do
  it "parallel test" do
    io, ret1, ret2, ret3 = Parallel.run(Time.new(2018, 1, 1, 0, 0, 0))
    ret1.should eq "return job1"
    ret2.should eq "return job2"
    ret3.should eq "return job3"
  end
end
