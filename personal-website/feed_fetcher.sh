#!/bin/bash

date > /tmp/date

bundle exec rails feed_runner:fetch_feed
