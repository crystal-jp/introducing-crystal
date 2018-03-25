require "./spec_helper"
require "./../src/myecho_07_display_help_banner.cr"

describe MyEcho do
  describe MyEcho::Cli do
    describe "run" do
      it "writes the content of args to specified IO with args" do
        io = IO::Memory.new
        myecho = MyEcho::Cli.new(io)
        myecho.run(["foo", "bar"])
        io.to_s.should eq "foo bar\n"
      end
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
      # tag::help[]
      describe "writes the help to specified IO" do
        it "with '-h'" do
          io = IO::Memory.new
          myecho = MyEcho::Cli.new(io)
          myecho.run(["-h"])
          io.to_s.should eq <<-HELP_MESSAGE

          My echo.

          Usage: myecho [options] [arguments]

              -h, --help                       show help
              -v, --version                    show version

          HELP_MESSAGE
        end
      end
      # end::help[]
    end
  end
end
