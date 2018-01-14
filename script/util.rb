# frozen_string_literal: true

require 'shellwords'

def sh(*cmd, **opt)
  out = opt[:out]
  puts "$ #{cmd.shelljoin}#{out ? " >#{out.shellescape}" : ''}"
  ok = system(*cmd.map(&:to_s), **opt)
  exit 1 unless ok
end

def cd(path, &block)
  puts "$ pushd #{path.to_s.shellescape}"
  Dir.chdir(path, &block)
  puts '$ popd'
end
