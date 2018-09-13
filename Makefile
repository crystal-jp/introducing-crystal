-include Makefile.local

PREFIX = build

ASCIIDOCTOR_PDF_FLAGS = \
  -r asciidoctor-pdf-cjk
ASCIIDOCTOR_ROUGE_FLAGS = \
  -a source-highlighter=rouge \
  -a rouge-theme=base16

ASCIIDOCTOR_PRINT_PDF_FLAGS = \
  $(ASCIIDOCTOR_PDF_FLAGS) \
  -a media=print \
  -a pdf-style=config/asciidoctor-pdf/themes/print-theme.yml
ASCIIDOCTOR_WEB_PDF_FLAGS = \
  $(ASCIIDOCTOR_PDF_FLAGS) \
  $(ASCIIDOCTOR_ROUGE_FLAGS) \
  -a pdf-style=config/asciidoctor-pdf/themes/web-theme.yml

ASCIIDOCTOR_HTML_FLAGS = \
  -r asciidoctor-rouge \
  $(ASCIIDOCTOR_ROUGE_FLAGS)

PRINT_PDF = $(PREFIX)/introducing-crystal-print.pdf
WEB_PDF = $(PREFIX)/introducing-crystal-web.pdf
PDFS = $(PRINT_PDF) $(WEB_PDF)
HTML = $(PREFIX)/introducing-crystal.html

CONTENT_ADOCS = $(shell find [0-9][0-9]-* -name '*.adoc')
PDF_ADOCS = index.adoc $(CONTENT_ADOCS)
JEKYLL_ADOCS = $(CONTENT_ADOCS) $(shell find docs -name '*.adoc')
ADOCS = index.adoc $(shell find [0-9][0-9]-* docs -name '*.adoc')
EXAMPLES = $(wildcard */examples/*.cr) $(wildcard */examples/**/*.cr)
PROJECTS = $(wildcard */projects/*)
PROJECT_CRS = $(and $(PROJECTS), $(shell find $(PROJECTS) -type d -name lib -prune -o -name '*.cr' -print))
PDF_ASSETS = $(shell find [0-9][0-9]-* docs/assets/images -not -name '*.adoc')
CRS = $(EXAMPLES) $(PROJECT_CRS)

.PHONY: all
all: pdf jekyll

.PHONY: pdf print-pdf web-pdf
pdf: print-pdf web-pdf
print-pdf: $(PRINT_PDF)
web-pdf: $(WEB_PDF)

$(PRINT_PDF): $(PDF_ADOCS) $(PDF_ASSETS)
	bundle exec asciidoctor-pdf $(ASCIIDOCTOR_PRINT_PDF_FLAGS) -o $@ $<

$(WEB_PDF): $(PDF_ADOCS) $(PDF_ASSETS)
	bundle exec asciidoctor-pdf $(ASCIIDOCTOR_WEB_PDF_FLAGS) -o $@ $<

.PHONY: jekyll
jekyll:
	bundle exec jekyll build

.PHONY: lint lint-full redpen rubocop crystal-format format backspace
lint: redpen crystal-format backspace
lint-full: lint rubocop

redpen:
	redpen -c config/redpen/conf.xml -L ja README.md 2>/dev/null
	redpen -c config/redpen/conf.xml -L ja $(ADOCS) 2>/dev/null

rubocop:
	bundle exec rubocop

crystal-format:
	crystal tool format --check $(CRS)

format:
	crystal tool format $(CRS)

backspace:
	! grep -e '\x08' README.md $(ADOCS)

.PHONY: test example-test project-test
test: example-test project-test

example-test:
	@PREFIX=$(PREFIX) ./script/example-test.rb $(EXAMPLES)

project-test:
	@./script/project-test.rb $(PROJECTS)

.PHONY: clean
clean:
	rm -rf build
