#!/usr/bin/env ruby
# frozen_string_literal: true

require 'pathname'
require_relative './util'

EXAMPLES = ARGV.to_a
EXAMPLE_DIR = Pathname.new(ENV.fetch('PREFIX', 'build')) / 'example'

EXAMPLES.each do |example|
  path = Pathname.new(example)
  lines = path.read.lines.map do |line|
    case line
    when /\A *?# => (.*)\n\z/
      expected = Regexp.last_match(1)
      ".inspect.should eq(#{expected.inspect})\n"
    when /\A(.*?) # => (.*)\n\z/
      expr = Regexp.last_match(1)
      expected = Regexp.last_match(2)
      "(#{expr}).inspect.should eq(#{expected.inspect})\n"
    else
      line
    end
  end
  lines.prepend <<~CR
    require "spec"
    it #{path.basename.to_s.inspect} do
  CR
  lines.append %(end\n)

  example_cr_path = EXAMPLE_DIR / path
  example_cr_path.dirname.mkpath
  example_cr_path.write lines.join
  sh 'crystal', 'run', example_cr_path.to_s
end
