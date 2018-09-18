# tag::file[]
# 色を表す `enum` を定義
enum Color
  Red
  Green
  Blue

  # 値を直接指定することもできる
  Yellow = 100
end

def color_name(color : Color)
  color
end

# ファイルの開く際にモードを表す `enum` を定義
@[Flags]
enum FileMode
  Read
  Write
end

# tag::main[]
# `enum` は定数と同じように `::` で参照する。
Color::Red # => Red

# オートキャストが発動して、 `:green` が `Color::Green` に変換される。
color_name(:green) # => Green

# `@[Flags]` のついた `enum` は `|` で複数指定できる。
FileMode::Read | FileMode::Write # => Read | Write
# end::main[]
# end::file[]
