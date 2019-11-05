FROM alpine:edge
MAINTAINER TSUYUSATO Kitsune <make.just.on@gmail.com>

ADD vendor/redpen-distribution-1.10.1 /opt/redpen
RUN apk --update add curl crystal openjdk8 ruby ruby-dev ruby-json ruby-bigdecimal ruby-etc ruby-bundler make git gcc g++ musl-dev libxml2-dev gmp-dev openssl-dev openssh-client yaml-dev && \
    git clone https://github.com/crystal-lang/shards /tmp/shards && \
    cd /tmp/shards && \
    make CRFLAGS=--release && \
    cp bin/shards /usr/local/bin/shards && \
    cd / && rm -rf /tmp/shards && \
    ln -s /opt/redpen/bin/redpen /usr/local/bin/redpen && \
    adduser -S circleci

USER circleci
