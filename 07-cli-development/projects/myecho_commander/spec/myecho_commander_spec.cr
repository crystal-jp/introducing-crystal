require "./spec_helper"

describe "crystal run command" do
  describe "output args" do
    it "with arbitrary args" do
      `crystal run src/myecho_commander.cr -- foo bar`.should eq "foo bar\n"
    end
  end
  describe "output version" do
    it "with '-v'" do
      `crystal run src/myecho_commander.cr -- -v`.should eq MyechoCommander::VERSION + "\n"
    end
    it "with '--version'" do
      `crystal run src/myecho_commander.cr -- --version`.should eq MyechoCommander::VERSION + "\n"
    end
  end
  describe "output help" do
    it "with '-h'" do
      `crystal run src/myecho_commander.cr -- -h`.should eq <<-HELP_MESSAGE
        myecho - My echo.

        Usage:
          myecho [flags] [arguments]

        Commands:
          help [command]  # Help about any command.

        Flags:
          -h, --help     # Help for this command. default: 'false'.
              --prefix   # prefix to each arguments. default: ''.
          -v, --version  # show version. default: 'false'.

      HELP_MESSAGE
    end
    it "with '--help'" do
      `crystal run src/myecho_commander.cr -- --help`.should eq <<-HELP_MESSAGE
        myecho - My echo.

        Usage:
          myecho [flags] [arguments]

        Commands:
          help [command]  # Help about any command.

        Flags:
          -h, --help     # Help for this command. default: 'false'.
              --prefix   # prefix to each arguments. default: ''.
          -v, --version  # show version. default: 'false'.

      HELP_MESSAGE
    end
  end
  describe "output prefixed args" do
    it "with '--prefix PREFIX'" do
      `crystal run src/myecho_commander.cr -- --prefix pre_ foo bar baz`.should eq "pre_foo pre_bar pre_baz\n"
    end
  end
end
