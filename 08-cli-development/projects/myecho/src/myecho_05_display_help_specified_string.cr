require "./myecho/*"
require "option_parser"

module MyEcho
  class Cli
    def initialize(@io : IO = STDOUT)
    end

    class Options
      property display_version : Bool = false
      property args : Array(String) = [] of String
      property display_help : Bool = false
    end

    def run(args)
      # オプション設定を格納する
      options = Options.new

      # OptionParserを用いたオプションの設定
      OptionParser.parse(args) do |parser|
        # tag::help[]
        parser.on("-h", "--help", "show help") do
          options.display_help = true
        end
        # end::help[]
        parser.on("-v", "--version", "show version") do # <1>
          options.display_version = true
        end
        parser.unknown_args do |unknown_args|
          options.args = unknown_args
        end
      end

      # tag::display_help[]
      # ヘルプの表示
      if options.display_help
        @io.print "helpです。" + "\n"
        return
      end
      # end::display_help[]

      # バージョンの表示
      if options.display_version
        @io.print MyEcho::VERSION + "\n"
        return
      end

      # 引数の表示
      @io.print options.args.join(" ") + "\n"
    end
  end
end
