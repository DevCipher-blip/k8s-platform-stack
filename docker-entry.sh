#!/bin/sh
set -e

rm -f /oms-api/tmp/pids/server.pid

rails server -b "0.0.0.0"

exec "$@"