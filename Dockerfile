# FROM alpine:3.4
# FROM ruby:2.4.1-alpine
# FROM ruby:2.5.1-alpine
FROM ruby:2.5.1-alpine3.7

ENV LANG C.UTF-8
ENV ROOT_PATH /happydiary
# ENV RUNTIME_PACKAGES="libxml2-dev libxslt-dev libstdc++ tzdata mariadb-client-libs nodejs ca-certificates"\
    # DEV_PACKAGES="build-base mariadb-dev"

# ENV RUNTIME_PACKAGES="ruby ruby-irb ruby-json ruby-rake ruby-bigdecimal ruby-io-console ruby-dev libxml2-dev libxslt-dev libstdc++ tzdata mariadb-client-libs nodejs ca-certificates"\
#     DEV_PACKAGES="build-base mariadb-dev"

RUN mkdir $ROOT_PATH
WORKDIR $ROOT_PATH
ADD Gemfile $ROOT_PATH/Gemfile
ADD Gemfile.lock $ROOT_PATH/Gemfile.lock

RUN apk add --no-cache --update build-base \
                                linux-headers \
                                mariadb-dev \
                                nodejs \
                                tzdata \
                                libc6-compat \
                                libxml2-dev libxslt-dev libstdc++ mariadb-client-libs nodejs ca-certificates

RUN bundle install --jobs `expr $(cat /proc/cpuinfo | grep -c "cpu cores") - 1` --retry 3
#
# RUN apk add --update --no-cache $RUNTIME_PACKAGES
# RUN apk add --update --no-cache  --virtual=.build-dependencies $DEV_PACKAGES \
#     && apk del .build-dependencies \
#     && gem install bundler -N && bundle config build.nokogiri --use-system-libraries \
#     && bundle install -j4
# RUN rm /usr/bin/mysql* && rm /usr/lib/mysqld*
RUN rm /usr/bin/mysql*

# RUN apk update && \
#     apk upgrade && \
#     apk add --update --no-cache --virtual=.build-dependencies \
#       build-base \
#       curl-dev \
#       linux-headers \
#       libxml2-dev \
#       libxslt-dev \
#       postgresql-dev \
#       ruby-dev \
#       yaml-dev \
#       zlib-dev && \
#     apk add --update --no-cache \
#       bash \
#       git \
#       openssh \
#       postgresql \
#       ruby-json \
#       tzdata \
#       yaml && \

ADD . $ROOT_PATH

# CMD ["rails", "server", "-b", "0.0.0.0"]

EXPOSE 3000

