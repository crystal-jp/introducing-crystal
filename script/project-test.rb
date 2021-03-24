#!/usr/bin/env ruby
# frozen_string_literal: true

require 'pathname'
require_relative './util'
require_relative './spinner'

puts 'Project Test:'
puts

Spinner.start

PROJECTS = Pathname.glob('[0-9][0-9]-*/projects/*/').sort

def progress(index, project, message)
  index = (index + 1).to_s.rjust(PROJECTS.size.to_s.size)
  result = "\e[34m[#{index}/#{PROJECTS.size}]\e[0m"
  result += " \e[1mProject \e[4m#{project}\e[0m" if project
  result += " \e[35m#{message}\e[0m" if message
  result
end

PROJECTS.each_with_index do |project, i|
  path = project.realpath

  if (path / 'Makefile').exist?
    Spinner.show progress(i, project, '(custom > deps)')
    sh 'make', chdir: path
    Spinner.show progress(i, project, '(custom)')
    sh 'make test', chdir: path
  else
    Spinner.show progress(i, project, '(deps)')
    sh 'shards --ignore-crystal-version', chdir: path
    Spinner.show progress(i, project, nil)
    sh 'crystal', 'spec', chdir: path
  end
end

Spinner.stop

message = progress(PROJECTS.size - 1, nil, 'finish')
if Spinner::CI
  puts message
else
  puts "\e[G\e[K  \e[33m∙∙∙\e[0m #{message}"
end
puts
