require "./spec_helper"
require "./../src/myecho_03_display_version_v.cr"

describe MyEcho do
  describe MyEcho::Cli do
    describe "run" do
      it "writes the content of args to specified IO with args" do
        io = IO::Memory.new
        myecho = MyEcho::Cli.new(io)
        myecho.run(["foo", "bar"])
        io.to_s.should eq "foo bar\n"
      end
      # tag::version[]
      describe "writes the version to specified IO" do
        it "with '-v'" do
          io = IO::Memory.new                      # <1>
          myecho = MyEcho::Cli.new(io)             # <2>
          myecho.run(["-v"])                       # <3>
          io.to_s.should eq MyEcho::VERSION + "\n" # <4>
        end
      end
      # end::version[]
    end
  end
end
