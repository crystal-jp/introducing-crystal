require "./myecho_clim/*"
require "clim"

module MyechoClim
  class Cli < Clim
    main_command
    desc "My echo."
    usage "myecho [options] [arguments] ..."
    string "--prefix PREFIX", desc: "prefix to each arguments.", default: ""
    bool "-v", "--version", desc: "show version.", default: false
    run do |opts, args|
      # バージョンの表示
      if opts["version"].as(Bool)
        puts MyechoClim::VERSION
        next
      end

      # prefixをつける
      prefix = opts["prefix"].as(String)
      unless prefix.empty?
        puts args.map { |arg| prefix + arg }.join(" ")
        next
      end

      # 引数の表示
      puts args.join(" ")
    end
  end
end

MyechoClim::Cli.start(ARGV)
