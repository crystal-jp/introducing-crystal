# techbookfest4

技術書典4で頒布する本を管理するリポジトリです。

## 必要なもの

  - Ruby 2.5.0
  - Bundler
  - [Redpen](https://redpen.cc)

## ビルド方法

`bundle install` して `make` すればビルドできます。

```console
$ bundle install --path=vendor/bundle
$ make
```

生成されたファイルは `build` ディレクトリ以下にあります。

```console
$ ls build
techbookfest4-print.pdf techbookfest4-web.pdf techbookfest4.html
```

それぞれ印刷用の PDF、Web 公開用の PDF、HTML です。

## テスト

Redpen による文章のチェック等や `crystal tool format` によるフォーマットのチェックは `make lint` で実行できます。

```console
$ make lint
```

Example テストやプロジェクトのテストは `make test` で実行できます。

```console
$ make test
```

この2つが通るようにがんばってください。

## 文章の書き方

それぞれのディレクトリにある `content.adoc` に Asciidoc 形式で執筆してください。

Asciidoc 形式については次に挙げるリンクでも参考にしてください。

  - [Asciidoctor のユーザマニュアル](http://asciidoctor.org/docs/user-manual/):
    あらゆることが書いてありますが、長いので読むのがしんどいです。
  - [Asciidoc 簡易メモ](https://qiita.com/hbsnow/items/88e1414ac97501af17ff):
    日本語の記事です。よくまとまってます。
  - [Asciidoc 入門](https://qiita.com/xmeta/items/de667a8b8a0f982e123a):
    同じく日本語の記事です。

### コードの挿入について

原稿にコードを挿入する場合は、Asciidoc の `include` 機能を利用してください。
これはコードと記事を分離して、コードに対してコンパイルができる状態を保つためです。

```asciidoc
[source,crystal]
----
include::./examples/code.cr[]
----
```

コードはディレクトリの `examples` 以下に置いてください。
また、現状は言語に `crystal` を指定してもシンタックスハイライトがされませんが[既に Rouge に Pull Request は送ってある](https://github.com/jneen/rouge/pull/863)ので構わず指定してください。
特に、そのために `ruby` 等を代わりに指定するのは絶対にやめてください。
Crystal は Ruby ではありません。

`examples` ディレクトリ以下に置いた Crystal のコードは `make test` の際にいくつか変換を施したのち実行されます。

変換のルールは以下の通りです。

#### 式の後に `# =>` のようなコメントが続く場合

```crystal
1 + 2 # => 3
```

このように変換されます。

```crystal
require "spec"

it "code.cr" do
  (1 + 2).inspect.should eq("3")
end
```

期待する文字列に16進数の数値が含まれる場合、その部分は適当な16進数の文字列にマッチするものとして扱われます。
これは、インスタンスを `inspect` した際にオブジェクトのアドレスが表示されるので、それに対応するためです。

#### `# =>` から始まる行の場合

```crystal
begin
  1 + 2
end
# => 3
```

このように変換されます。

```crystal
require "spec"

it "code.cr" do
  begin
    1 + 2
  end
  .inspect.should eq("3")
end
```

#### 式の後に `# raises` が続く場合

```crystal
[1, 2][3] # raises IndexError (Index out of bounds)
```

このように変換されます。

```crystal
require "spec"

it "code.cr" do
  expect_raises(IndexError, "Index out of bounds") { [1, 2][3] }
end
```

括弧に囲まれた部分は省略できて、その場合はエラーメッセージに対して検査が行われません。

#### `# tag::main[]` と `# end::main[]`

`# =>` を含む場合コード全体が `it` で囲まれることになるのですが、 `def` 等の定義はブロックの中に書けないのでブロックの位置を指定したい場合があります。
その場合は `# tag::main[]` というコメントと `# end::main[]` というコメントで囲ってください。

このコメントは Asciidoc で[タグ領域の指定](http://asciidoctor.org/docs/user-manual/#by-tagged-regions)に使うものなので、 `include` した結果にも現れないので安心してください。

```crystal
def foo
  42
end

# tag::main[]
foo # => 42
# end::main[]
```

このように変換されます。

```crystal
def foo
  42
end

require "spec"

it "code.cr" do
  (42).inspect.should eq("42")
end
```

#### `# output:`

`# output:` で出力のテストができます。

```crystal
puts "Hello, World!"
puts "Crystal"

# output:
# Hello, World!
# Crystal
```

`# output:` と `# =>{` や `# raises` は併用できません。

### Shards のプロジェクトについて

いくつかの章では説明のためにプロジェクトを作るかと思います。
その場合は `projects` ディレクトリ以下にプロジェクトを配置すると、 `make test` の際にプロジェクトのビルドとテストが実行されます。

ビルドとテストは、

  - `Makefile` が無い場合は、 `shards build` と `crystal spec` を実行します。
  - `Makefile` がある場合は、 `make` と `make test` を実行します。

という風にして実行します。
