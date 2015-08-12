FROM ruby:2.2.2
MAINTAINER martin@stabenfeldt.net

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev
RUN mkdir /app
WORKDIR /app
ADD Gemfile /app/Gemfile
RUN bundle update --jobs 20 --retry 5
ADD . /app
