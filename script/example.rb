# frozen_string_literal: true

require_relative './util'

EXAMPLE_DIR = TEMP_DIR / 'example'

# Example represents example code.
class Example
  def initialize(original_path)
    @original_path = original_path
    @mode = :normal
    @main_start = @main_end = false
    @output = []
  end

  attr_reader :original_path, :mode

  def path
    EXAMPLE_DIR / @original_path
  end

  def code
    @lines = @original_path.read.lines
    @lines = @lines.map.with_index { |line, i| convert line, i }
    @lines = inject @lines
    @lines.join
  end

  def output
    @output.join
  end
end

# Convert part:
class Example
  RE_ASSERT_FULL = /\A\s*?# => (.*)\n\z/.freeze
  RE_ASSERT      = /\A((?~#)) # => (.*)\n\z/.freeze
  RE_RAISE       = /\A((?~#)) # raises (\w+)(?: \((.*)\))?\n\z/.freeze

  private def convert(line, offset)
    result = convert_assert_all(line)
    result ||= convert_main(line, offset)
    result ||= convert_compileonly(line)
    result ||= save_output(line, offset)
    result || line
  end

  private def convert_assert_all(line)
    convert_assert_full(line) || convert_assert(line) || convert_raise(line)
  end

  private def convert_assert_full(line)
    match = line.match(RE_ASSERT_FULL)
    return unless match

    mode! :assert
    expection = convert_expection match[1]
    ".inspect.should #{expection}\n"
  end

  private def convert_assert(line)
    match = line.match(RE_ASSERT)
    return unless match

    mode! :assert
    expr = match[1]
    expection = convert_expection match[2]
    "(#{expr}).inspect.should #{expection}\n"
  end

  private def convert_raise(line)
    match = line.match(RE_RAISE)
    return unless match

    mode! :assert
    *, expr, klass, text = *match
    return "expect_raises(#{klass}, #{text.inspect}) { #{expr} }\n" if text

    "expect_raises(#{klass}) { #{expr} }\n"
  end

  private def convert_compileonly(line)
    return unless line == "# tag::compileonly\[\]\n"

    mode! :compileonly
    line
  end

  private def convert_main(line, offset)
    main_header(line, offset) || main_footer(line, offset)
  end

  private def main_header(line, offset)
    return unless line == "# tag::main[]\n"
    raise '"# tag::main[]" is duplicated' if @main_start

    @main_start = offset
    line
  end

  private def main_footer(line, offset)
    return unless line == "# end::main[]\n"
    raise '"# tag::main[]" is missing' unless @main_start
    raise '"# end::main[]" is duplicated' if @main_end

    @main_end = offset
    line
  end

  private def save_output(line, offset)
    return unless line == "# output:\n"

    mode! :output
    (offset + 1...@lines.size).each do |i|
      break unless @lines[i].start_with? '# '

      @output << @lines[i][2..]
    end
    line
  end

  private def convert_expection(pattern)
    if pattern.match?(/0x\h+/)
      pattern = Regexp.escape pattern
      pattern = pattern.gsub(/0x\h+/, '0x[0-9a-fA-F]+')
      "match(#{/\A#{pattern}\z/.inspect})"
    else
      "eq(#{pattern.inspect})"
    end
  end

  private def mode!(mode)
    raise "Expected mode is normal or #{mode}, but current mode is #{@mode}" unless @mode == :normal || @mode == mode

    @mode = mode
  end
end

# Inject part:
class Example
  private def inject(lines)
    case @mode
    when :assert then inject_assert lines
    when :compileonly, :normal, :output then lines
    end
  end

  private def inject_assert(lines)
    if @main_start
      raise '"# end::main[]" is missing' unless @main_end

      lines[@main_start] = assert_header
      lines[@main_end] = assert_footer
    else
      lines.prepend assert_header
      lines.append assert_footer
    end
    lines
  end

  private def assert_header
    <<~CR
      require "spec"
      it #{@original_path.basename.to_s.inspect} do
    CR
  end

  private def assert_footer
    "end\n"
  end
end
