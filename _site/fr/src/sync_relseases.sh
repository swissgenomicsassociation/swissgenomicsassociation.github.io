#!/bin/bash

echo "syncing release from working repo to website assets"
rsync -avz -P \
  ~/so/web/swissgenomicsassociation/mendelian_disease_interpretation/latex/mendelian_disease_interpretation_v1.pdf \
    assets/release/mendelian_disease_interpretation/latest/

rsync -avz -P \
  ~/so/web/swissgenomicsassociation/verifiable_infrastructure_pillars/latex/verifiable_infrastructure_pillars.pdf \
    assets/release/verifiable_infrastructure_pillars/latest/

rsync -avz -P \
  ~/so/web/swissgenomicsassociation/founding_charter/latex/founding_charter.pdf \
    assets/release/founding_charter/latest/

