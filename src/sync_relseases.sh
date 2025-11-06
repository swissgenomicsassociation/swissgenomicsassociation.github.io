#!/bin/bash

echo "syncing release from working repo to website assets"
rsync -avz -P ~/so/web/swissgenomicsassociation/mendelian_disease_interpretation/latex/mendelian_disease_interpretation_v1.pdf \
    assets/release/mendelian_disease_interpretation/latest/

