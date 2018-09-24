require "./myecho_admiral/*"
require "admiral"

module MyechoAdmiral
  class Cli < Admiral::Command
    define_version MyechoAdmiral::VERSION, short: v
    define_help description: "My echo.", short: h

    define_flag prefix : String?,
      description: "prefix to each arguments.",
      long: prefix

    def run
      # prefixをつける
      prefix = flags.prefix
      unless prefix.nil?
        puts arguments.map { |arg| prefix + arg }.join(" ")
        return
      end

      # 引数の表示
      puts arguments.join(" ")
    end
  end
end

MyechoAdmiral::Cli.run
