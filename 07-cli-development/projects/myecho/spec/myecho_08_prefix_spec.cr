require "./spec_helper"
require "./../src/myecho_08_prefix.cr"

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
      describe "writes the help to specified IO" do
        it "with '-h'" do
          io = IO::Memory.new
          myecho = MyEcho::Cli.new(io)
          myecho.run(["-h"])
          io.to_s.should eq <<-HELP_MESSAGE

          My echo.

          Usage: myecho [options] [arguments]

              --prefix PREFIX                  prefix to each arguments
              -h, --help                       show help
              -v, --version                    show version

          HELP_MESSAGE
        end
      end
      # tag::prefix[]
      describe "prefix specified string to each arguments" do
        it "with '--prefix PREFIX'" do
          io = IO::Memory.new
          myecho = MyEcho::Cli.new(io)
          myecho.run(["--prefix", "pre_", "foo", "bar", "baz"])
          io.to_s.should eq "pre_foo pre_bar pre_baz\n"
        end
      end
      # end::prefix[]
    end
  end
end
