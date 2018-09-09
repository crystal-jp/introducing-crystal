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
      property prefix : String? = nil
    end

    def run(args)
      # オプション設定を格納する
      options = Options.new

      # OptionParserを用いたオプションの設定
      OptionParser.parse(args) do |parser|
        parser.banner = <<-BANNER

        My echo.

        Usage: myecho [options] [arguments]

        BANNER
        parser.on("--prefix PREFIX", "prefix to each arguments") do |prefix|
          options.prefix = prefix
        end
        parser.on("-h", "--help", "show help") do
          options.display_help = true
        end
        parser.on("-v", "--version", "show version") do
          options.display_version = true
        end
        parser.unknown_args do |unknown_args|
          options.args = unknown_args
        end
        # ヘルプメッセージの格納
        options.help_message = parser.to_s + "\n"
      end

      # ヘルプの表示
      if options.display_help
        @io.print options.help_message
        return
      end

      # バージョンの表示
      if options.display_version
        @io.print MyEcho::VERSION + "\n"
        return
      end

      # prefixをつける
      prefix = options.prefix
      unless prefix.nil?
        @io.print options.args.map { |arg| prefix + arg }.join(" ") + "\n"
        return
      end

      # 引数の表示
      @io.print options.args.join(" ") + "\n"
    end
  end
end
