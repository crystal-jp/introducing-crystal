require "./spec_helper"

describe Kemal::Sample do
  it "get /hello" do
    get "/hello"
    response.body.should eq "<!DOCTYPE html>\n<html>\n<head>\n  <meta charset=\"utf-8\"/>\n  <title>hello</title>\n</head>\n<body>\n  Hello World\n</body>\n</html>"
  end
end
