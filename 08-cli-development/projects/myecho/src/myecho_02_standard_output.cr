require "./myecho/*"

module MyEcho
  class Cli
    def initialize(@io : IO = STDOUT) # <1>
    end

    def run(args)                     # <2>
      @io.print args.join(" ") + "\n" # <3>
    end
  end
end
