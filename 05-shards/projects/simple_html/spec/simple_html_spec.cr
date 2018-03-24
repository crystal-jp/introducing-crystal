require "./spec_helper"

describe SimpleHtml do
  describe ".build" do
    it "builds HTML from page title and body content." do
      SimpleHtml.build(["Title", "Body"]).should eq "<html><head><title>Title</title></head><body><h1>Title</h1><p>Body</p></body></html>"
    end
  end
end
