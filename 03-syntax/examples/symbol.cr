:foo
:+

# シンボルは `Symbol` 型です
typeof(:foo) # => Symbol

# 空白やエスケープの必要な文字を含む場合は `"` で囲みます
:"foo bar"
:"foo\nbar"
