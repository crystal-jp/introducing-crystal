require "spec"
require "./bear"

describe Bear do
  describe "#bark" do
    it "returns \"がおー\"." do
      Bear.new.bark.should eq "がおー"
    end
  end

  describe "#bite" do
    # Bear#bite は未実装
    pending "retuns \"がぶがぶ\"." do
      Bear.new.bite.should eq "がぶがぶ"
    end
  end
end
