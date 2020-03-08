#!/bin/bash

date > /tmp/date

source $SECRETS_FILE

cd /usr/src/app

RAILS_ENV=production bundle exec rails feed_runner:fetch_feed > /tmp/feed_output 2> /tmp/feed_error
