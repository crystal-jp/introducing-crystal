#!/usr/bin/env ruby
# frozen_string_literal: true

require 'pathname'
require 'shellwords'
require_relative './util'

def run_project_test(tid, path)
  if (path / 'Makefile').exist?
    sh 'make', '-C', path, thread_id: tid
    sh 'make', '-C', path, 'test', thread_id: tid
  else
    sh 'sh', '-c', "cd #{path.to_s.shellescape}; shards", thread_id: tid
    sh 'sh', '-c', "cd #{path.to_s.shellescape}; crystal spec", thread_id: tid
  end
end

NUM_THREAD = 2
queue = Queue.new
threads = []
NUM_THREAD.times do |i|
  thread = Thread.new(i) do |tid|
    while path = queue.shift
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

threads.each &:join
