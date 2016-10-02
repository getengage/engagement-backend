FROM ruby:2.2.3
MAINTAINER Nick Soto <nickesoto@gmail.com>

# Install build-essential, node, and npm
RUN apt-get update && apt-get install -y build-essential
RUN curl -sL https://deb.nodesource.com/setup_4.x | bash - \
    && apt-get install -y nodejs \
    && npm install -g npm

RUN gem install bundler \
    && bundle install --jobs 4
RUN npm install

ENV APP_HOME /app
RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME

ADD Gemfile* $APP_HOME/
RUN bundle install

ADD . $APP_HOME