# Production image for the OMS API.
# The build stage compiles native gems (pg, puma, bootsnap); the runtime stage
# only carries the shared libraries they link against and runs as a non-root user.
ARG RUBY_VERSION=3.4.12

FROM ruby:${RUBY_VERSION}-slim AS build

ENV BUNDLE_PATH=/usr/local/bundle \
    BUNDLE_DEPLOYMENT=1 \
    BUNDLE_WITHOUT=development:test

RUN apt-get update -qq \
    && apt-get install -y --no-install-recommends build-essential libpq-dev libyaml-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY Gemfile Gemfile.lock .ruby-version ./
RUN bundle install \
    && rm -rf "${BUNDLE_PATH}"/ruby/*/cache "${BUNDLE_PATH}"/ruby/*/bundler/gems/*/.git

COPY . .
RUN bundle exec bootsnap precompile app/ lib/


FROM ruby:${RUBY_VERSION}-slim

ENV RAILS_ENV=production \
    BUNDLE_PATH=/usr/local/bundle \
    BUNDLE_DEPLOYMENT=1 \
    BUNDLE_WITHOUT=development:test

RUN apt-get update -qq \
    && apt-get install -y --no-install-recommends libpq5 libyaml-0-2 \
    && rm -rf /var/lib/apt/lists/* \
    && groupadd --system --gid 1000 rails \
    && useradd --system --uid 1000 --gid rails --home-dir /app --shell /usr/sbin/nologin rails

WORKDIR /app

COPY --from=build /usr/local/bundle /usr/local/bundle
COPY --from=build /app /app
RUN mkdir -p tmp/pids log && chown -R rails:rails tmp log

USER 1000:1000

EXPOSE 3000

ENTRYPOINT ["./docker-entry.sh"]
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
