-include Makefile.local

PREFIX = build

ASCIIDOCTOR_PDF_FLAGS = \
  -r asciidoctor-pdf-cjk
ASCIIDOCTOR_ROUGE_FLAGS = \
  -a source-highlighter=rouge \
  -a rouge-style=base16 \
  -a rouge-theme=base16

ASCIIDOCTOR_PRINT_PDF_FLAGS = \
  $(ASCIIDOCTOR_PDF_FLAGS) \
  -a media=print \
  -a pdf-style=config/asciidoctor-pdf/themes/print-theme.yml
ASCIIDOCTOR_WEB_PDF_FLAGS = \
  $(ASCIIDOCTOR_PDF_FLAGS) \
  -r asciidoctor-pdf-cjk \
  $(ASCIIDOCTOR_ROUGE_FLAGS)

ASCIIDOCTOR_HTML_FLAGS = \
  -r asciidoctor-rouge \
  $(ASCIIDOCTOR_ROUGE_FLAGS)

BUILD_PDFS = \
  $(PREFIX)/techbookfest4-print.pdf \
  $(PREFIX)/techbookfest4-web.pdf
BUILD_HTML = $(PREFIX)/techbookfest4.html
BUILD_FILES = $(BUILD_PDFS) $(BUILD_HTML)

ADOCS = \
  index.adoc \
  $(wildcard */*.adoc)
EXAMPLES = $(wildcard */examples/*.cr)
PROJECTS = $(wildcard */projects/*)
PROJECT_CRS = $(shell find $(PROJECTS) -name '*.cr')
ASSETS = $(shell find [0-9][0-9]-* -not -name '*.adoc')
CRS = $(EXAMPLES) $(PROJECT_CRS)

.PHONY: all
all: $(BUILD_FILES)

.PHONY: pdf print-pdf web-pdf html
pdf: print-pdf web-pdf
print-pdf: $(PREFIX)/techbookfest4-print.pdf
web-pdf: $(PREFIX)/techbookfest4-web.pdf
html: $(PREFIX)/techbookfest4.html

$(PREFIX)/techbookfest4-print.pdf: $(ADOCS) $(ASSETS)
	bundle exec asciidoctor-pdf $(ASCIIDOCTOR_PRINT_PDF_FLAGS) -o $@ $<

$(PREFIX)/techbookfest4-web.pdf: $(ADOCS) $(ASSETS)
	bundle exec asciidoctor-pdf $(ASCIIDOCTOR_WEB_PDF_FLAGS) -o $@ $<

$(PREFIX)/techbookfest4.html: $(ADOCS) $(ASSETS)
	bundle exec asciidoctor $(ASCIIDOCTOR_HTML_FLAGS) -o $@ $<

.PHONY: lint redpen rubocop crystal-format format
lint: redpen rubocop crystal-format

redpen:
	redpen -c config/redpen/conf.xml -L ja $(ADOCS) 2>/dev/null

rubocop:
	bundle exec rubocop

crystal-format:
	crystal tool format --check $(CRS)

format:
	crystal tool format $(CRS)

.PHONY: test example-test project-test
test: example-test project-test

example-test:
	@PREFIX=$(PREFIX) ./script/example-test.rb $(EXAMPLES)

project-test:
	@./script/project-test.rb $(PROJECTS)

.PHONY: clean
clean:
	rm -rf build
