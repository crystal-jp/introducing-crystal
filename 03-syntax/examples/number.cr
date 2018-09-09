# 何も指定していない数値は `Int32` 、 `Float64` 型
typeof(123)  # => Int32
typeof(3.14) # => Float64

# 符号付き整数型
[typeof(123i8), typeof(123i16), typeof(123i32), typeof(123i64), typeof(123i128)]
# => [Int8, Int16, Int32, Int64, Int128]

# 符号無し整数型
[typeof(123u8), typeof(123u16), typeof(123u32), typeof(123u64), typeof(123u128)]
# => [UInt8, UInt16, UInt32, UInt64, UInt128]

# 浮動小数点型
[typeof(3.14f32), typeof(3.14f64)] # => [Float32, Float64]
