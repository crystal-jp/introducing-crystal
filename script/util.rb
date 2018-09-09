# frozen_string_literal: true

require 'open3'
require 'shellwords'

NORMAL  = "\e[1m$\e[0m"
START   = "\e[33m$\e[0m"
SUCCESS = "\e[32m$\e[0m"
FAIL    = "\e[31m$\e[0m"

def sh(*cmd, thread_id: 0, **opt)
  out = opt.delete :out
  cmdline = "#{cmd.shelljoin}#{out ? " >#{out.to_s.shellescape}" : ''}"
  puts "[#{thread_id}] #{START} #{cmdline}"
  if out
    stdout, output, status = Open3.capture3(*cmd.map(&:to_s), **opt)
    out.write stdout
  else
    output, status = Open3.capture2e(*cmd.map(&:to_s), **opt)
  end
  if status.success?
    puts "[#{thread_id}] #{SUCCESS} #{cmdline}"
  else
    puts "[#{thread_id}] #{FAIL} #{cmdline}"
    print output
    puts
    raise "command failed: #{cmdline}"
  end
end
