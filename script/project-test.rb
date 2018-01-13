#!/usr/bin/env ruby
# frozen_string_literal: true

require 'pathname'
require_relative './util'

PROJECTS = ARGV.to_a

PROJECTS.each do |project|
  path = Pathname.new(project)

  cd(path) do
    if (path / 'Makefile').exist?
      sh 'make'
      sh 'make test'
    else
      sh 'shards'
      sh 'crystal', 'spec'
    end
  end
end
