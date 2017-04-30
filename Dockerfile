FROM ruby:latest
ENV LANG C.UTF-8

RUN apt-get update -qq && apt-get install -y libpq-dev
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash - && apt-get install -y nodejs build-essential && npm install -g phantomjs-prebuilt
RUN rm -rf /var/lib/apt/lists/*

RUN gem install bundler

ENV APP_HOME /geeami
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

ADD Gemfile* $APP_HOME/

ENV BUNDLE_GEMFILE=$APP_HOME/Gemfile \
  BUNDLE_JOBS=2 \
  BUNDLE_PATH=/bundle

ADD . $APP_HOME
