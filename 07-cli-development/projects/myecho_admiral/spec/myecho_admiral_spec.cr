require "./spec_helper"

describe "crystal run command" do
  describe "output args" do
    it "with arbitrary args" do
      `crystal run src/myecho_admiral.cr -- foo bar`.should eq "foo bar\n"
    end
  end
  describe "output version" do
    it "with '-v'" do
      `crystal run src/myecho_admiral.cr -- -v`.should eq MyechoAdmiral::VERSION + "\n"
    end
    it "with '--version'" do
      `crystal run src/myecho_admiral.cr -- --version`.should eq MyechoAdmiral::VERSION + "\n"
    end
  end
  describe "output help" do
    it "with '-h'" do
      # 環境によって Usage が変わってしまうので先頭２行は削除
      `crystal run src/myecho_admiral.cr -- -h | sed 1,2d`.should eq <<-HELP_MESSAGE

      My echo.

      Flags:
        --help, -h (default: false)     # Displays help for the current command.
        --prefix                        # prefix to each arguments.
        --version, -v (default: false)

      HELP_MESSAGE
    end
    it "with '--help'" do
      # 環境によって Usage が変わってしまうので先頭２行は削除
      `crystal run src/myecho_admiral.cr -- --help | sed 1,2d`.should eq <<-HELP_MESSAGE

      My echo.

      Flags:
        --help, -h (default: false)     # Displays help for the current command.
        --prefix                        # prefix to each arguments.
        --version, -v (default: false)

      HELP_MESSAGE
    end
  end
  describe "output prefixed args" do
    it "with '--prefix PREFIX'" do
      `crystal run src/myecho_admiral.cr -- --prefix pre_ foo bar baz`.should eq "pre_foo pre_bar pre_baz\n"
    end
  end
end
