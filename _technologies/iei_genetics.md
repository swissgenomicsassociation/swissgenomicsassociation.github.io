---
title: "IEI genetics database"
date: 2025-01-01T00:00:01+10:00
weight: 4
---

## Streamline genetic diagnosis of IEI 
to quantify both known and uncertain evidence into a single, evidence-based conclusion

[![I.E.I genetics database](/images/technologies/var_risk_est_iei_genetics.png)](https://iei-genetics.github.io)

## What we offer

* **Pre-calculated variant probabilities**
  * Prior probabilities for 54 814 ClinVar variants across 557 IEI genes
  * Integrates population allele frequencies, ClinVar classifications and Hardy-Weinberg expectations under AD, AR and X-linked models
  * Available as flat files with TSV, Rds and HTML interface

* **Gene summary datasets**
  * Per-gene summaries of pathogenic burden and inheritance mode distribution
  * Aligned to IUIS classification and ACMG guidelines
  * Ready for direct import into your analysis pipelines

## What you can do

* **Evidence-aware diagnosis**
  * Combine observed and unobserved variants in a Bayesian framework
  * Generate posterior probabilities with credible intervals for each candidate gene or variant
  * Distinguish supported, plausible-but-unseen and excluded findings

* **Streamlined reporting**
  * Produce structured, confidence-ranked reports for clinicians or end users
  * Accelerate candidate gene ranking and manual review

* **Seamless integration**
  * Plug in datasets as a diagnostic engine into your bioinformat platform
  * Reduce manual curation, speed up turnaround and deliver a consistent, high-confidence product

## Free version

The public base model IEI genetics database is available at:

**<https://iei-genetics.github.io>**

This resource provides core data, and the related publication covers the foundational technical implementations.
Full text: [PDF link](https://www.medrxiv.org/content/10.1101/2025.03.25.25324607v3.full.pdf+html).

Please cite: 

```
@article {Lawless2025VarRiskEst,
	author = {Lawless, Dylan},
	title = {Quantitative prior probabilities for disease-causing variants reveal the top genetic contributors in inborn errors of immunity},
	year = {2025},
	doi = {10.1101/2025.03.25.25324607},
	publisher = {Cold Spring Harbor Laboratory Press}
}
```

## Professional version

A professional version was developed as a follow up to the open source public version.
It includes extended data via a database download ([readme.md](https://drive.google.com/file/d/1cDE3gETAr8KkVnJ-WfKANHricGWGTBiU/view?usp=share_link)) containing flat files in TSV, Rds and an HTML interface, and is licenced for commercial use. 
This version is available for companies wishing to use these data in their analysis results, in cases where the public licence may restrict commercial product development.

<!-- Our licence covers the necessary use of commercial cloud high-performance computing for development. -->

<!-- <script async -->
<!--   src="https://js.stripe.com/v3/buy-button.js"> -->
<!-- </script> -->

<!-- <stripe-buy-button -->
<!--   buy-button-id="buy_btn_1RHOGH2MuWhgHdB6QlL4hC5O" -->
<!--   publishable-key="pk_live_51RHMa52MuWhgHdB68R2P58CJu2YtBR6fOCHE28yaSapxKGbafxhmUMFuQ8fowJud5Gbt01k5lXbztuJQnqI93XGI00HGGGyhdA" -->
<!-- > -->
<!-- </stripe-buy-button> -->
