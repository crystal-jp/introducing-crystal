require "html_builder"
require "./simple_html/*"

module SimpleHtml
  def self.run(args : Array(String))
    if args.size == 2
      STDOUT << build(args[0], args[1]) << '\n'
    else
      STDERR << usage << '\n'
    end
  end

  def self.build(title, body)
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

  def self.usage
    "usage: simple_html TITLE BODY"
  end
end

SimpleHtml.run(ARGV)
