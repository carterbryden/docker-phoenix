FROM ubuntu:latest

MAINTAINER Nikolauska <nikolauska1@gmail.com>

# Elixir requires UTF-8
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# update and install software
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y curl wget git make sudo tar bzip2 libfontconfig && \
    wget http://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb && \
    dpkg -i erlang-solutions_1.0_all.deb && \
    apt-get update && \
    rm erlang-solutions_1.0_all.deb && \
    touch /etc/init.d/couchdb && \
    apt-get install -y elixir erlang-dev erlang-dialyzer erlang-parsetools && \
    apt-get clean

RUN mix local.hex --force && \
    mix local.rebar --force && \
    mix archive.install --force https://github.com/phoenixframework/archives/raw/master/phoenix_new.ez

# Install nodejs LTS
RUN curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash - && sudo apt-get install -y nodejs

# Install phantomjs and node sass
RUN sudo npm install -g node-sass phantomjs-prebuilt
