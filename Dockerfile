FROM ruby:2.2.3
MAINTAINER Nick Soto <nickesoto@gmail.com>

# Install build-essential, libpq-dev for pg, node, and npm
RUN apt-get update && apt-get install -y build-essential libpq-dev
RUN curl -sL https://deb.nodesource.com/setup_4.x | bash - \
    && apt-get install -y nodejs \
    && npm install -g npm
RUN npm install

ENV APP_HOME /app
RUN mkdir $APP_HOME
WORKDIR $APP_HOME
ADD Gemfile $APP_HOME/Gemfile
ADD Gemfile.lock $APP_HOME/Gemfile.lock
RUN bundle install --jobs 4
ADD . $APP_HOME

