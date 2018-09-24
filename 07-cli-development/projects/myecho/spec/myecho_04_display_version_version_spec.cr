require "./spec_helper"
require "./../src/myecho_04_display_version_version.cr"

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
          io = IO::Memory.new
          myecho = MyEcho::Cli.new(io)
          myecho.run(["-v"])
          io.to_s.should eq MyEcho::VERSION + "\n"
        end

        # 新しいテストケース
        it "with '--version'" do
          io = IO::Memory.new
          myecho = MyEcho::Cli.new(io)
          myecho.run(["--version"]) # <1>
          io.to_s.should eq MyEcho::VERSION + "\n"
        end
      end
      # end::version[]
    end
  end
end
