require "html_builder"

# Build simple HTML source.
module SimpleHtml
  VERSION = "0.1.0"

  def self.build(args : Array(String))
    title = args[0]
    body = args[1]
    HTML.build {
      html {
        head {
          title { text title }
        }
        body {
          h1 { text title }
          p { text body }
        }
      }
    }
  end
end

if File.basename(PROGRAM_NAME) == File.basename(__FILE__, ".cr")
  puts SimpleHtml.build(ARGV)
end
