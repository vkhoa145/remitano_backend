FROM ruby:3.3.1-slim

ENV TZ="Asia/Tokyo"
ENV LANG C.UTF-8

RUN apt-get update -y && \
  apt-get upgrade -y && \
  apt-get install -y \
  build-essential default-libmysqlclient-dev vim less

WORKDIR /app
COPY Gemfile Gemfile.lock /app/
RUN bundle install

COPY . /app

VOLUME /app/public
VOLUME /app/tmp

EXPOSE 3000
