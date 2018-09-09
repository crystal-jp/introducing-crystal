#!/usr/bin/env ruby
# frozen_string_literal: true

require 'pathname'
require 'tmpdir'
require_relative './util'
require_relative './example'

def run_example_test(tid, example_path)
  example = Example.new example_path
  example.path.dirname.mkpath
  example.path.write example.code
  case example.mode
  when :compileonly
    sh 'crystal', 'build', '--no-codegen', example.path, thread_id: tid
  when :normal, :assert
    sh 'crystal', 'run', example.path, thread_id: tid
  when :output
    Dir.mktmpdir do |tmp|
      tmp = Pathname.new(tmp)
      expected = tmp / 'expected.txt'
      result = tmp / 'result.txt'
      expected.write example.output
      sh 'crystal', 'run', example.path, thread_id: tid, out: result
      sh 'diff', '-u', expected, result, thread_id: tid
    end
  end
end

NUM_THREAD = 4
queue = Queue.new
threads = []
NUM_THREAD.times do |i|
  thread = Thread.new(i) do |tid|
    while example_path = queue.shift
      run_example_test tid, example_path
    end
  end
  thread.abort_on_exception = true
  threads << thread
end

EXAMPLES = ARGV.to_a.sort
EXAMPLES.each do |example|
  queue << Pathname.new(example)
end
queue.close

threads.each &:join
