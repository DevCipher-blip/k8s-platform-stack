FROM ruby:2.7.1

RUN apt-get update -qq \
    && apt-get install -y postgresql-client build-essential libpq-dev

WORKDIR /oms-api

ADD Gemfile Gemfile
ADD Gemfile.lock Gemfile.lock

RUN bundle install

COPY . .

RUN chmod +x docker-entry.sh
CMD ["sh", "docker-entry.sh"]

EXPOSE 3000



