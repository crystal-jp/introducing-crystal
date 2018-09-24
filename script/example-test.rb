#!/usr/bin/env ruby
# frozen_string_literal: true

require 'pathname'
require_relative './util'
require_relative './example'
require_relative './spinner'

puts 'Example Test:'
puts

Spinner.start

EXAMPLES = Pathname.glob('[0-9][0-9]-*/examples/**/*.cr').sort

def progress(index, example, message)
  index = (index + 1).to_s.rjust(EXAMPLES.size.to_s.size)
  result = "\e[34m[#{index}/#{EXAMPLES.size}]\e[0m"
  result += " \e[1;4m#{example.original_path}\e[0m" if example
  result += " \e[35m#{message}\e[0m"
  result
end

EXAMPLES.each_with_index do |example, i|
  example = Example.new example

  example.path.dirname.mkpath
  example.path.write example.code
  case example.mode
  when :compileonly
    Spinner.show progress(i, example, '(compile only)')
    sh 'crystal', 'build', '--no-codegen', example.path
  when :normal, :assert
    Spinner.show progress(i, example, '(assert)')
    sh 'crystal', 'run', example.path
  when :output
    Spinner.show progress(i, example, '(output)')
    temp_dir = example.path.dirname / example.path.basename('.cr')
    temp_dir.mkpath
    expected = temp_dir / 'expected.txt'
    result = temp_dir / 'result.txt'
    expected.write example.output
    Spinner.show progress(i, example, '(output > run)')
    sh 'crystal', 'run', example.path, out: result
    Spinner.show progress(i, example, '(output > diff)')
    sh 'diff', '-u', expected.basename, result.basename, chdir: temp_dir
  end
end

Spinner.stop

message = progress(EXAMPLES.size - 1, nil, 'finish')
if Spinner::CI
  puts message
else
  puts "\e[G\e[K  \e[33m∙∙∙\e[0m #{message}"
end
puts
