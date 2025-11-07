#!/bin/bash
outdir=~/Desktop
outfile="$outdir/temp.txt"

rm -f "$outfile"
mkdir -p "$outdir"

for f in profile.md members.md login.md; do
  echo "===== $f =====" >> "$outfile"
  cat "$f" >> "$outfile"
  echo -e "\n\n" >> "$outfile"
done

echo "Combined contents written to $outfile"

