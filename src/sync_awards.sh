#!/bin/bash

set -e

echo "syncing awards from working repo to website"

SOURCE=~/so/web/swissgenomicsassociation/sga_awards/2027_open_omics/README.md
DEST=awards/2027/open_omics/index.md

mkdir -p "$(dirname "$DEST")"

rsync -avz -P \
  "$SOURCE" \
  "$DEST"
