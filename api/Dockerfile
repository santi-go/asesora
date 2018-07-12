FROM ruby:2.5.0

RUN mkdir /api
WORKDIR /api

COPY Gemfile Gemfile.lock /api/
RUN bundle install -j 10

COPY . /api
