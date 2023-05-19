FROM ruby:3.0.2

RUN gem install bundler
RUN mkdir /app

RUN apt update -qq && apt install -y git vim

RUN cd /app && git clone https://github.com/ghostnumber7/mongoriver.git && git clone https://github.com/ghostnumber7/mosql

RUN cd /app/mongoriver && bundle install && bundler exec rake build && bundler exec rake install
RUN cd /app/mosql && bundle install && bundler exec rake build && bundler exec rake install

CMD [ "bash" ]
