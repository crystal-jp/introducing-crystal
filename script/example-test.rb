#!/usr/bin/env ruby
# frozen_string_literal: true

require 'pathname'
require 'tmpdir'
require_relative './util'
require_relative './example'

EXAMPLES = ARGV.to_a.sort

EXAMPLES.each do |example|
  example = Example.new Pathname.new(example)

  example.path.dirname.mkpath
  example.path.write example.code
  case example.mode
  when :compileonly
    sh 'crystal', 'build', '--no-codegen', example.path.to_s
  when :normal, :assert
    sh 'crystal', 'run', example.path.to_s
  when :output
    Dir.mktmpdir do |tmp|
      tmp = Pathname.new(tmp)
      expected = tmp / 'expected.txt'
      result = tmp / 'result.txt'
      expected.write example.output
      sh 'crystal', 'run', example.path, out: result.to_s
      cd tmp do
        sh 'diff', '-u', expected.basename, result.basename
      end
    end
  end
end
