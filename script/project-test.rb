#!/usr/bin/env ruby
# frozen_string_literal: true

require 'pathname'
require 'shellwords'
require_relative './util'

def run_project_test(tid, path)
  if (path / 'Makefile').exist?
    sh 'make', thread_id: tid, chdir: path
    sh 'make', 'test', thread_id: tid, chdir: path
  else
    sh 'shards', thread_id: tid, chdir: path
    sh 'crystal', 'spec', thread_id: tid, chdir: path
  end
end

NUM_THREAD = 4
queue = Queue.new
threads = []
NUM_THREAD.times do |i|
  thread = Thread.new(i) do |tid|
    loop do
      path = queue.shift
      break unless path
      run_project_test tid, path
    end
  end
  thread.abort_on_exception = true
  threads << thread
end

PROJECTS = ARGV.to_a

PROJECTS.each do |project|
  queue << Pathname.new(project).realpath
end
queue.close

threads.each(&:join)
