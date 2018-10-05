#!/usr/bin/dumb-init /bin/sh
set -e

# Require the bucket to be defined.
if [ "$BUCKET" = "" ]; then echo "\$BUCKET is required to be defined and non-empty."; exit 1; fi

# Replace the $BUCKET name.
envsubst '$BUCKET' < /etc/nginx/nginx.conf > /etc/nginx/.nginx.conf
mv /etc/nginx/.nginx.conf /etc/nginx/nginx.conf

# Start services.
nginx &
gcsproxy &

# Wait for interruptions and exit the main container when something a child process exits.
trap "kill 0" INT KILL STOP TERM CHLD
wait
