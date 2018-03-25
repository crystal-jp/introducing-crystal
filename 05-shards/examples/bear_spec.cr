require "spec"
require "./bear"

describe Bear do
  describe "#bark" do
    it "returns \"がおー\"." do
      Bear.new.bark.should eq "がおー"
    end
  end
end
