## Evidence ratio reporting standard (ERRS)

Last update: 20260116

- [Latest PDF version of the standard]({{ '/assets/release/sga_errs/latest/sga_errs_1.0.pdf' }}){: target="_blank"}
- [Latest HTML version of the standard]({{ '/assets/release/sga_errs/latest/sga_errs_1.0' }}){: target="_blank"}

Statistical results are increasingly stored, queried, and reused outside the context in which they were generated. Across clinical trials, observational studies, and large scale analyses, results derived from different models and outcome types are often reduced to partial summaries that do not travel well between systems.

The Evidence Ratio Reporting Standard (ERRS) defines a normative reporting specification for statistical evidence derived from likelihood based analyses. It states what information must be reported when an evidence ratio is reported, so that results remain interpretable, comparable, and auditable when reused.

ERRS governs reporting only. It does not prescribe analytical methods, estimands, inferential procedures, thresholds, or decision rules.

### What ERRS defines

ERRS specifies a minimal reporting unit derived from a single statistical model and dataset. Each reported result includes an effect estimate, its associated uncertainty interval, and a likelihood based evidence ratio reported on the log10 scale. These quantities report magnitude, precision, and evidential support as distinct objects, without collapsing them into a single decision metric.

The standard also defines minimal coherence and provenance requirements, ensuring that reported quantities are internally consistent and traceable to their underlying model specifications.

### Why this matters

Clinical and biomedical studies routinely analyse heterogeneous endpoints using appropriate but different statistical models. When results are stored for secondary analysis, comparison, or regulatory review, evidential information is often reduced to threshold based indicators or omitted entirely.

ERRS enables results from diverse analyses to be represented using a common evidential structure while retaining their native effect scales and uncertainty measures. This supports consistent storage, comparison, and reuse of results across endpoints, studies, and analytic systems, including clinical trial databases and regulatory workflows.

## How to cite this standard

Swiss Genomics Association. (2026). *Evidence Ratio Reporting Standard* (SGA-ERRS-1.0.0). Zenodo. <https://doi.org/10.5281/zenodo.18261076>

{% raw %}
```bibtex
@article{sga_errs_2026,
  title        = {Evidence Ratio Reporting Standard {SGA-ERRS-1}.0.0},
  author       = {{Swiss Genomics Association}},
  institution  = {Swiss Genomics Association},
  year         = {2026},
  date         = {2026-01-15},
  number       = {SGA-ERRS-1.0},
  type         = {Normative standard},
  journal      = {Zenodo},
  organization = {Zenodo},
  doi          = {10.5281/zenodo.18261076},
  url          = {https://www.swissgenomicsassociation.ch/assets/release/sga_errs/latest/sga_errs_1.0.pdf},
  howpublished = {\url{https://github.com/swissgenomicsassociation/sga_errs}},
  urldate      = {2026-01-15},
  version      = {sga-errs-1.0}
}
```

{% endraw %}

[![DOI](https://zenodo.org/badge/1135132727.svg)](https://doi.org/10.5281/zenodo.18261075)
