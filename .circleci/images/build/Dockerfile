FROM alpine:edge
MAINTAINER TSUYUSATO Kitsune <make.just.on@gmail.com>

ADD redpen-distribution-1.10.1 /opt/redpen
RUN apk --update add curl openjdk8 ruby ruby-json ruby-etc ruby-bundler make git gcc libxml2-dev gmp-dev openssl-dev && \
    echo http://public.portalier.com/alpine/testing >> /etc/apk/repositories && \
    curl http://public.portalier.com/alpine/julien%40portalier.com-56dab02e.rsa.pub -o /etc/apk/keys/julien@portalier.com-56dab02e.rsa.pub && \
    apk --update add crystal shards && \
    ln -s /opt/redpen/bin/redpen /usr/local/bin/redpen && \
    adduser -S circleci

USER circleci
