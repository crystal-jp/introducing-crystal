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
      property help_message : String = ""
    end

    def run(args)
      # オプション設定を格納する
      options = Options.new

      # tag::option_parser_start[]
      # OptionParserを用いたオプションの設定
      OptionParser.parse(args) do |parser|
        # end::option_parser_start[]
        parser.on("-h", "--help", "show help") do
          options.display_help = true
        end
        parser.on("-v", "--version", "show version") do # <1>
          options.display_version = true
        end
        parser.unknown_args do |unknown_args|
          options.args = unknown_args
        end
        # tag::option_parser_end[]
        # ヘルプメッセージの格納
        # すべての設定を行った後で格納する
        options.help_message = parser.to_s + "\n"
      end
      # end::option_parser_end[]

      # tag::display_help[]
      # ヘルプの表示
      if options.display_help
        @io.print options.help_message
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
