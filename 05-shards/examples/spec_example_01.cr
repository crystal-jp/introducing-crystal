require "spec"

describe Array do
  describe "#first" do
    context "self is empty." do
      it "raises an Enumerable::EmptyError." do
        expect_raises(Enumerable::EmptyError) {
          # Enumerable::EmptyError が発生しなければテスト失敗
          Array(Int32).new.first
        }
      end
    end
  end
end
