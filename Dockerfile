FROM ruby:3.0.2

RUN gem install bundler
RUN mkdir /app

RUN apt update -qq && apt install -y git

RUN cd /app && git clone https://github.com/ghostnumber7/mosql && cd mosql && \
  bundle install && gem build mosql.gemspec && bundler exec gem install mosql-0.5.1.gem

CMD [ "bash" ]
