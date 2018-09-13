require "./myecho_commander/*"
require "commander"

cli = Commander::Command.new do |cmd|
  cmd.use = "myecho"
  cmd.long = "My echo."

  cmd.flags.add do |flag|
    flag.name = "prefix"
    flag.long = "--prefix"
    flag.default = ""
    flag.description = "prefix to each arguments."
  end

  cmd.flags.add do |flag|
    flag.name = "version"
    flag.long = "--version"
    flag.short = "-v"
    flag.default = false
    flag.description = "show version."
  end

  cmd.run do |options, arguments|
    # バージョンの表示
    if options.bool["version"]
      puts MyechoCommander::VERSION
      next
    end

    # prefixをつける
    prefix = options.string["prefix"]
    unless prefix.empty?
      puts arguments.map { |arg| prefix + arg }.join(" ")
      next
    end

    # 引数の表示
    puts arguments.join(" ")
  end
end

Commander.run(cli, ARGV)
