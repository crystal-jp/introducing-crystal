require "kemal"
require "db"
require "pg"
require "./kemal-sample/*"

module Kemal::Sample
  # tag::hello[]
  get "/hello" do |env|
    hello = "Hello World"
    render "src/views/hello.ecr"
  end
  # end::hello[]

  # tag::main[]
  database_url = "postgres://localhost:5432/kemal_sample_development"
  db = DB.open(database_url)

  ["/", "/articles"].each do |path|
    get path do |env|
      articles = [] of Hash(String, String | Int32)
      # tag::query[]
      db.query("select id, title, content from articles") do |rs|
        rs.each do
          article = {} of String => String | Int32
          article["id"] = rs.read(Int32)
          article["title"] = rs.read(String)
          article["content"] = rs.read(String)
          articles << article
        end
      end
      # end::query[]
      db.close
      render "src/views/index.ecr", "src/views/application.ecr"
    end
  end

  get "/articles/new" do |env|
    render "src/views/articles/new.ecr", "src/views/application.ecr"
  end

  post "/articles" do |env|
    # env.params.bodyでformのvalueを取得できます
    title_param = env.params.body["title"]
    content_param = env.params.body["content"]
    params = [] of String
    params << title_param
    params << content_param
    # update, insert, deleteは以下のようにexecでアップデートを実行します
    db.exec("insert into articles(title, content) values($1::text, $2::text)", params)
    db.close
    env.redirect "/"
  end

  get "/articles/:id" do |env|
    articles = [] of Hash(String, String | Int32)
    article = {} of String => String | Int32
    id = env.params.url["id"].to_i32
    params = [] of Int32
    params << id
    sql = "select id, title, content from articles where id = $1::int8"
    article["id"], article["title"], article["content"] = 
      db.query_one(sql, params, as: {Int32, String, String})
    articles << article
    db.close
    render "src/views/articles/show.ecr", "src/views/application.ecr"
  end
  # end::main[]
end

Kemal.run