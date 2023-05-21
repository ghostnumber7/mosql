FROM ruby:3.0.2

RUN apt update -qq && apt install -y git vim

RUN gem install bundler
RUN mkdir /app

COPY . /app

WORKDIR /app

ARG github_token
ENV BUNDLE_RUBYGEMS__PKG__GITHUB__COM=$github_token
RUN bundle config set --global rubygems.pkg.github.com ${BUNDLE_RUBYGEMS__PKG__GITHUB__COM}

RUN bundler install
RUN bundler exec rake build
RUN bundler exec rake install

CMD [ "bash" ]
