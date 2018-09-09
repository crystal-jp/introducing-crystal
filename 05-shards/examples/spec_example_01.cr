require "spec"

describe Array do
  describe "#first" do
    context "self is empty." do
      it "raises an IndexError." do
        expect_raises(IndexError) {
          # IndexError が発生しなければテスト失敗
          Array(Int32).new.first
        }
      end
    end
  end
end
