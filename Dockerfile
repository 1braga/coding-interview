FROM ruby:3.4.5

RUN apt-get update -qq && apt-get install -y \
    build-essential \
    libpq-dev \
    nodejs \
    yarn \

WORKDIR /app

COPY Gemfile* ./
RUN bundle install

COPY ..

EXPOSE 3000