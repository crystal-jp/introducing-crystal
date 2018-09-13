require "./myecho/*"
require "option_parser" # <1>

module MyEcho
  class Cli
    def initialize(@io : IO = STDOUT)
    end

    class Options
      property display_version : Bool = false
      property args : Array(String) = [] of String
    end

    def run(args)
      # オプション設定を格納する
      options = Options.new

      # OptionParserを用いたオプションの設定
      OptionParser.parse(args) do |parser| # <2>
        parser.on("-v", "show version") do # <3>
          options.display_version = true
        end
        parser.unknown_args do |unknown_args| # <4>
          options.args = unknown_args
        end
      end

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
