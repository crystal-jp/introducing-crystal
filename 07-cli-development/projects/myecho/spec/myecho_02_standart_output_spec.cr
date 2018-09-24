require "./spec_helper"
require "./../src/myecho_02_standard_output.cr"

# tag::spec[]
describe MyEcho do
  describe MyEcho::Cli do
    describe "run" do
      it "writes the content of args to specified IO" do
        io = IO::Memory.new           # <1>
        myecho = MyEcho::Cli.new(io)  # <2>
        myecho.run(["foo", "bar"])    # <3>
        io.to_s.should eq "foo bar\n" # <4>
      end
    end
  end
end
# end::spec[]
