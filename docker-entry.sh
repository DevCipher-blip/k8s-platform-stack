#!/bin/sh
set -e

# tmp/ may be an empty volume when the root filesystem is read-only.
mkdir -p tmp/pids tmp/cache
rm -f tmp/pids/server.pid

# Creates the database and loads the schema on first boot, runs pending
# migrations afterwards. Disable it when migrations run as a separate job.
if [ "${RUN_DB_PREPARE:-true}" = "true" ]; then
  bin/rails db:prepare
fi

exec "$@"
