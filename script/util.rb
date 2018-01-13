# frozen_string_literal: true

require 'english'
require 'shellwords'

def sh(*cmd)
  puts "$ #{Shellwords.join(cmd)}"
  system(*cmd)
  exit 1 unless $CHILD_STATUS.success?
end

def cd(path, &block)
  puts "$ pushd #{Shellwords.escape(path.to_s)}"
  Dir.chdir(path, &block)
  puts '$ popd'
end
