require "./myecho_clim/*"
require "clim"

module MyechoClim
  class Cli < Clim
    main do
      desc "My echo."
      usage "myecho [options] [arguments] ..."
      option "--prefix PREFIX", type: String, desc: "prefix to each arguments.", default: ""
      version MyechoClim::VERSION, short: "-v"
      run do |options, arguments|
        # prefixをつける
        prefix = options.prefix
        unless prefix.empty?
          puts arguments.all_args.map { |argument| prefix + argument }.join(" ")
          next
        end

        # 引数の表示
        puts arguments.all_args.join(" ")
      end
    end
  end
end

MyechoClim::Cli.start(ARGV)
