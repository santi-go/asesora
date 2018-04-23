FROM ruby:2.5.0

RUN mkdir /api
WORKDIR /api

COPY . /api
RUN rm Gemfile.lock

RUN bundle install -j 10
