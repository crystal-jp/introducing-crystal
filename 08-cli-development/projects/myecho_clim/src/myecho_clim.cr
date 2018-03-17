require "./myecho_clim/*"
require "clim"

module MyechoClim
  class Cli < Clim
    main_command do
      desc "My echo."
      usage "myecho [options] [arguments] ..."
      option "--prefix PREFIX", type: String, desc: "prefix to each arguments.", default: ""
      version MyechoClim::VERSION, short: "-v"
      run do |options, arguments|
        # prefixをつける
        prefix = options.prefix
        unless prefix.empty?
          puts arguments.map { |argument| prefix + argument }.join(" ")
          return
        end

        # 引数の表示
        puts arguments.join(" ")
      end
    end
  end
end

MyechoClim::Cli.start(ARGV)
