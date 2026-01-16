#!/bin/bash

set -e
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

rsync -avz -P \
  ~/so/web/swissgenomicsassociation/sga_qem/latex/sga_qem_1.0.pdf \
    assets/release/sga_qem/latest/

rsync -avz -P \
  ~/so/web/swissgenomicsassociation/sga_errs/html/sga_errs_1.0.md \
    assets/release/sga_errs/latest/

rsync -avz -P \
  ~/so/web/swissgenomicsassociation/sga_errs/latex/sga_errs_1.0.pdf \
    assets/release/sga_errs/latest/

rsync -avz -P \
  ~/so/web/swissgenomicsassociation/sga_qem/html/sga_qem_1.0.md \
    assets/release/sga_qem/latest/
