require "./spec_helper"

describe "crystal run command" do
  describe "output args" do
    it "with arbitrary args" do
      `crystal run src/myecho_clim.cr -- foo bar`.should eq "foo bar\n"
    end
  end
  describe "output version" do
    it "with '-v'" do
      `crystal run src/myecho_clim.cr -- -v`.should eq MyechoClim::VERSION + "\n"
    end
    it "with '--version'" do
      `crystal run src/myecho_clim.cr -- --version`.should eq MyechoClim::VERSION + "\n"
    end
  end
  describe "output help" do
    it "with '--help'" do
      `crystal run src/myecho_clim.cr -- --help`.should eq <<-HELP_MESSAGE

        My echo.

        Usage:

          myecho [options] [arguments] ...

        Options:

          --help                           Show this help.
          --prefix PREFIX                  prefix to each arguments.  [default:""]
          -v, --version                    show version.  [default:false]


      HELP_MESSAGE
    end
  end
  describe "output prefixed args" do
    it "with '--prefix PREFIX'" do
      `crystal run src/myecho_clim.cr -- --prefix pre_ foo bar baz`.should eq "pre_foo pre_bar pre_baz\n"
    end
  end
end
