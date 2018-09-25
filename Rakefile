# frozen_string_literal: true

unless ENV['BUNDLE_BIN_PATH']
  print "\e[1;31mDetect not bundler environment!! "
  puts "Re-execute with 'bundle exec'.\e[0m"
  sh 'bundle', 'exec', 'rake', *ARGV, verbose: false
  exit 0
end

require 'combine_pdf'
require 'pathname'

# =================
# === Variables ===
# =================

# The directory name to output built files
build_dir = Pathname.new 'build'
# The directory name to output temporary files
temp_dir  = Pathname.new '.tmp'

# The directory name to output built documents
build_docs_dir = build_dir / 'docs'

# PDF file names:
web_pdf   = build_dir / 'introducing-crystal-web.pdf'
print_pdf = build_dir / 'introducing-crystal-print.pdf'

# Asciidoctor files of contents
content_adoc_files = `git ls-files authors.adoc */content.adoc`
                     .lines(chomp: true)
                     .map { |filename| Pathname.new filename }
# Asciidoctor theme directory name
adoc_themes_dir = Pathname.new 'config/asciidoctor-pdf/themes'
# Asciidoctor theme file for Web PDF
adoc_web_theme = adoc_themes_dir / 'web-theme.yml'
# Asciidoctor theme file for print PDF
adoc_print_theme = adoc_themes_dir / 'print-theme.yml'
# Images using in document contents
image_files = `git ls-files docs/assets/images/[0-9][0-9]-*`
              .lines(chomp: true)
              .map { |filename| Pathname.new filename }
# PDF of front-cover page
cover_pdf = Pathname.new 'docs/assets/pdfs/cover.pdf'
# Crystal sources
crystal_files = `git ls-files *.cr`
                .lines(chomp: true)
                .map { |filename| Pathname.new filename }
# All files under docs directory
doc_files = `git ls-files docs`
            .lines(chomp: true)
            .map { |filename| Pathname.new filename }

# The base Asciidoctor option flags
adoc_base_flags = %w[-r asciidoctor-pdf-cjk]
# The Asciidoctor option flags to enable rouge syntax highlighting
adoc_rouge_flags = %w[
  -a source-highlighter=rouge
  -a rouge-theme=base16
]
# The Asciidoctor option flags for Web PDF
adoc_web_flags = [
  *adoc_base_flags,
  *adoc_rouge_flags,
  '-a', adoc_web_theme.to_s
]
# The Asciidoctor option flags for print PDF
adoc_print_flags = [
  *adoc_base_flags,
  '-a', 'media=print', '-a', "pdf-style=#{adoc_print_theme}"
]

# The Redpen option flags
redpen_flags = '-c config/redpen/conf.xml -L ja'

# =================
# === Tasks     ===
# =================

require 'rake/clean'

CLEAN.include(temp_dir)
directory temp_dir
CLOBBER.include(build_dir)
directory build_dir

ENV['TEMP_DIR'] = temp_dir.to_s

task 'default' => %w[pdf docs]

# =================
# === PDF       ===
# =================

desc 'Generate PDFs'
task 'pdf' => ['pdf:web', 'pdf:print']

namespace 'pdf' do
  file web_pdf => [
    'index.adoc', *content_adoc_files,
    *crystal_files, *image_files,
    adoc_web_theme, cover_pdf, build_dir
  ] do |t|
    temp_output = temp_dir / 'introducing-crystal-web.pdf'

    sh 'asciidoctor-pdf', *adoc_web_flags, '-o', temp_output.to_s, t.source

    pdf = CombinePDF.new
    pdf << CombinePDF.load(cover_pdf)
    pdf << CombinePDF.load(temp_output)
    pdf.save t.name
  end

  file print_pdf => [
    'index.adoc', *content_adoc_files,
    *crystal_files, *image_files,
    adoc_web_theme, build_dir
  ] do |t|
    sh 'asciidoctor-pdf', *adoc_print_flags, '-o', t.name, t.source
  end

  desc 'Generate PDF file for Web viewing'
  task 'web' => web_pdf
  desc 'Generate PDF file for printing'
  task 'print' => print_pdf
end

# =================
# === Docs      ===
# =================

file build_docs_dir => [
  *content_adoc_files, *doc_files,
  *crystal_files,
  web_pdf,
  '_config.yml'
] do
  sh 'jekyll', 'build'
  mkdir_p build_docs_dir / 'assets/pdfs'
  cp web_pdf, build_docs_dir / 'assets/pdfs/introducing-crystal.pdf'
end

desc 'Generate Web documents by Jekyll'
task 'docs' => build_docs_dir

namespace 'docs' do
  desc 'Serve Web documents with file watching by Jekyll'
  task 'watch' do
    sh 'jekyll', 'serve'
  end
end

# =================
# === Test      ===
# =================

desc 'Run all tests'
task 'test' => %w[test:example test:project]

namespace 'test' do
  desc 'Run example tests'
  task 'example' do
    ruby 'script/example-test.rb', verbose: false
  end

  desc 'Run project tests'
  task 'project' do
    ruby 'script/project-test.rb', verbose: false
  end
end

# =================
# === Lint      ===
# =================

desc 'Check format'
task 'lint' => %w[lint:md lint:adoc lint:rb lint:cr]

namespace 'lint' do
  desc 'Format files'
  task 'format' => %w[lint:rb:format lint:cr:format]

  desc 'Check Markdown text'
  task 'md' do
    sh "redpen #{redpen_flags} README.md 2>/dev/null"
  end

  desc 'Check Asciidoctor text'
  task 'adoc' do
    sh "redpen #{redpen_flags} $(git ls-files '*.adoc') 2>/dev/null"
  end

  desc 'Check Ruby source format'
  task 'rb' do
    sh 'rubocop'
  end

  namespace 'rb' do
    desc 'Format Ruby source'
    task 'format' do
      sh 'rubocop --auto-correct'
    end
  end

  desc 'Check Crystal source format'
  task 'cr' do
    sh "crystal tool format --check $(git ls-files '*.cr')"
  end

  namespace 'cr' do
    desc 'Format Crystal source'
    task 'format' do
      sh "crystal tool format $(git ls-files '*.cr')"
    end
  end
end
