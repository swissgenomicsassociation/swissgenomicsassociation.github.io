#!/bin/bash
# bundle install

sh src/sync_relseases.sh
bundle exec jekyll serve &
sleep 3

open -a Safari http://127.0.0.1:4000
