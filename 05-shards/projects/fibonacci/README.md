# fibonacci

The fibonacci number calculator for the Crystal programing language.

## Installation

1. Add the dependency to your `shard.yml`:
```yaml
dependencies:
  fibonacci:
    github: github_name/fibonacci
```
2. Run `shards install`

## Usage

```crystal
require "fibonacci"

f0 = Fibonacci.number(0) #=> 0_big_i
f1 = Fibonacci.number(1) #=> 1_big_i
f2 = Fibonacci.number(2) #=> 1_big_i
f3 = Fibonacci.number(3) #=> 2_big_i
f4 = Fibonacci.number(4) #=> 3_big_i
```

## Contributors

- [github_name](https://github.com/github_name) Your Git Name - creator, maintainer
