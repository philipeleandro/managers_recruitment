# syntax=docker/dockerfile:1
ARG RUBY_VERSION=3.3.1
FROM ruby:$RUBY_VERSION-slim

# Instalar pacotes básicos
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y curl libpq-dev nodejs build-essential git nodejs yarn nano && \
    rm -rf /var/lib/apt/lists/*

RUN adduser --disabled-password --gecos "" app

# Criar diretório da aplicação
WORKDIR /app

# Copiar Gemfile e instalar dependências
COPY Gemfile Gemfile.lock ./
RUN bundle install --jobs 4 --retry 3

# Copiar o código da aplicação
COPY --chown=app:app . .

# Copiar o arquivo credentials.yml.enc para o diretório de configuração
COPY config/credentials.yml.enc config/credentials.yml.enc

# Compilar Tailwind e assets
RUN bundle exec rails tailwindcss:build
RUN bundle exec rake assets:precompile

# Mudar para o usuário da aplicação
USER root

# Expor a porta do Rails
EXPOSE 3000
