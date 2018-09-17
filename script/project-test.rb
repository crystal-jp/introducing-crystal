#!/usr/bin/env ruby
# frozen_string_literal: true

require 'pathname'
require_relative './util'

PROJECTS = Pathname.glob('[0-9][0-9]-*/projects/*/')

PROJECTS.each do |project|
  path = project.realpath

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
