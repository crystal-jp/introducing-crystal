# frozen_string_literal: true

require 'open3'
require 'shellwords'

TEMP_DIR = Pathname.new ENV.fetch('TEMP_DIR', '.tmp')

FAIL_PROMPT = "\e[31m$\e[0m"

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

def fail_report(cmdline, output)
  puts
  puts
  puts "  #{FAIL_PROMPT} #{cmdline}"
  puts
  puts output.lines.map { |s| "  #{s}" }.join
  puts
end

def sh(*cmd, **opt)
  cmdline = calc_cmdline(*cmd, **opt)
  out = opt.delete :out
  output, status = sh_exec(*cmd, out: out, **opt)
  return if status.success?

  fail_report cmdline, output
  raise "command failed: #{cmdline}"
end
