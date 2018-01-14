# frozen_string_literal: true

require 'english'
require 'shellwords'

def sh(*cmd, **opt)
  out = opt[:out]
  puts "$ #{cmd.shelljoin}#{out ? " >#{out.shellescape}" : ''}"
  system(*cmd.map(&:to_s), **opt)
  exit 1 unless $CHILD_STATUS.success?
end

def cd(path, &block)
  puts "$ pushd #{path.to_s.shellescape}"
  Dir.chdir(path, &block)
  puts '$ popd'
end
