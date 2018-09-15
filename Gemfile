# frozen_string_literal: true

source 'https://rubygems.org'

# Fix `:github` URL to use `https` protocol.
git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

ruby '2.5.1'

gem 'asciidoctor'
gem 'asciidoctor-pdf'
gem 'asciidoctor-pdf-cjk'
gem 'asciidoctor-rouge',
    github: 'MakeNowJust/asciidoctor-rouge',
    branch: 'rouge-3'
gem 'rouge'

gem 'jekyll'
gem 'jekyll-theme-prologue'
group :jekyll_plugins do
  gem 'jekyll-asciidoc'
end

gem 'rake'
gem 'rubocop'
