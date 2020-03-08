FROM ruby:2.6.5
LABEL ca.rullmann.author="Ernst Rullmann" \
      ca.rullmann.email="e.rullmann@gmail.com" \
      ca.rullmann.version="1.0"

RUN apt-get update -qq && apt-get install -y nodejs postgresql-client rsync

RUN bundle config --global frozen 1
RUN gem install bundler

WORKDIR /website

COPY Gemfile Gemfile.lock ./
RUN bundle install
COPY . .

EXPOSE 8080

CMD ["./docker_run.sh"]