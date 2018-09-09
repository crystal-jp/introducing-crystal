require "spec"

describe Array do
  describe "#first?" do
    context "self is empty." do
      it "returns nil." do
        Array(Int32).new.first?.should be_nil
      end
    end

    context "self has elements." do
      it "returns receiver's first element." do
        [1, 2, 3].first?.should eq 1
      end
    end
  end
end
