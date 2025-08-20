FROM ruby:3.4.5

RUN apt-get update -qq && apt-get install -y \
    build-essential \
    libpq-dev
RUN apt-get install -y nodejs

WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

EXPOSE 3000