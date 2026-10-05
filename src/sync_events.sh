#!/bin/bash

set -e

echo "syncing events from working repo to website"

SOURCE=~/so/web/swissgenomicsassociation/sga_events/2027/seminar_1/README.md
DEST=events/2027/seminar_1/index.md

mkdir -p "$(dirname "$DEST")"

rsync -avz -P \
  "$SOURCE" \
  "$DEST"
