#!/bin/bash
# bundle install

sh src/sync_relseases.sh
sh src/sync_events.sh
sh src/sync_awards.sh

bundle exec jekyll serve &
sleep 3

open -a Safari http://127.0.0.1:4000
