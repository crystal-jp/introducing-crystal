# frozen_string_literal: true

require 'open3'
require 'shellwords'

NORMAL  = "\e[1m$\e[0m"
START   = "\e[33m$\e[0m"
SUCCESS = "\e[32m$\e[0m"
FAIL    = "\e[31m$\e[0m"

def sh_exec(*cmd, out:, **opt)
  if out
    stdout, output, status = Open3.capture3(*cmd.map(&:to_s), **opt)
    out.write stdout
  else
    output, status = Open3.capture2e(*cmd.map(&:to_s), **opt)
  end

  [output, status]
end

def calc_cmdline(*cmd, **opt)
  out = opt[:out]
  chdir = opt[:chdir]

  cmdline = chdir ? "cd #{chdir.to_s.shellescape}; " : ''
  cmdline += cmd.shelljoin
  cmdline += out ? " >#{out.to_s.shellescape}" : ''

  cmdline
end

def sh(*cmd, thread_id: 0, **opt)
  cmdline = calc_cmdline(*cmd, **opt)
  out = opt.delete :out
  puts "[#{thread_id}] #{START} #{cmdline}"
  output, status = sh_exec(*cmd, out: out, **opt)

  unless status.success?
    puts "[#{thread_id}] #{FAIL} #{cmdline}\n#{output}"
    raise "command failed: #{cmdline}"
  end

  puts "[#{thread_id}] #{SUCCESS} #{cmdline}"
end
