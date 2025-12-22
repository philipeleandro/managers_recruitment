# syntax=docker/dockerfile:1
ARG RUBY_VERSION=3.3.1
FROM ruby:$RUBY_VERSION-slim

WORKDIR /rails

# Instalar pacotes básicos
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y curl libpq-dev build-essential git nodejs yarn && \
    rm -rf /var/lib/apt/lists/*

# Instalar gems
COPY Gemfile Gemfile.lock ./
RUN gem install bundler && bundle install

# Copiar código da aplicação
COPY . .

# Expor porta do Rails
EXPOSE 3000
