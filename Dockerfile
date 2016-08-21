FROM alpine:3.2
MAINTAINER Gus Bonfante <gbonfant@me.com>

ENV BUILD_PACKAGES curl-dev ruby-dev build-base

RUN apk update && apk upgrade && apk add bash $BUILD_PACKAGES
RUN apk add ruby ruby-io-console ruby-bundler

ADD . /usr/app
WORKDIR /usr/app

RUN bundle install

CMD ["ruby", "lib/start.rb"]
