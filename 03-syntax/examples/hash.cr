# `"foo"` と `"bar"`というキーを持ったハッシュ
hash = {
  "foo" => 42,
  "bar" => 24,
}
typeof(hash) # => Hash(String, Int32)

# `"foo"` と `42` というキーを持ったハッシュ
hash = {
  "foo" => 24,
     42 => "bar",
}
typeof(hash) # => Hash(Int32 | String, Int32 | String)

# 空のハッシュの場合、型を明記します
{} of Int32 => String
typeof({} of Int32 => String) # => Hash(Int32, String)
