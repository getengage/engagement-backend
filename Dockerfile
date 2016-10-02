FROM ruby:2.2.3
MAINTAINER Nick Soto <nickesoto@gmail.com>

# Install build-essential, node, and npm
RUN apt-get update && apt-get install -y build-essential
RUN curl -sL https://deb.nodesource.com/setup_4.x | bash - \
    && apt-get install -y nodejs \
    && npm install -g npm

RUN mkdir -p /linting
WORKDIR /linting/

# Setup container for bundle and npm install
COPY ["package.json", "npm-shrinkwrap.json", "/linting/"]
COPY ["Gemfile", "Gemfile.lock", "/linting/"]
RUN gem install bundler \
    && bundle install --jobs 4
RUN npm install
ENV PATH /linting/node_modules/.bin:$PATH

RUN mkdir -p /app
WORKDIR /app/