<h1>Project design: Three pillars for verifiable genomic infrastructure</h1>

Last update: 20251130

<div class="contrib-note">
  <div class="contrib-note-content">
<p>
<strong>TLDR</strong>: Switzerland is building a shared genomic foundation so that hospitals, researchers, industry, and public services can trust and exchange results even when they use different technologies. The three pillars define one aligned approach for provenance, analysis variables, and verifiable clinical interpretation.
</p>
</div>
</div>

![Three pillars of a national-scale genomic ecosystem](/images/three_pillars.png)

**Figure.** Three pillars of a national-scale genomic ecosystem.


## Why is this needed?

<ul>
<li><strong>I am a clinician</strong> and I want genomic results that are traceable, explainable, and consistent across hospitals.</li>
<li><strong>I am a researcher</strong> and I want data that link reliably across studies and institutions.</li>
<li><strong>I work in industry</strong> and I want to deliver high quality results without exposing proprietary tools.</li>
<li><strong>I am a citizen</strong> and I want clarity about what my genome means, and trust that the result is based on verifiable evidence.</li>
</ul>

## What is the solution?

**Project name**: Consensus guideline for verifiable genomic decision infrastructure.

Open trusted standards allow hospitals, researchers, and commercial services to coordinate while keeping full independence in how they operate. 
The three pillars below show how Switzerland can build a shared genomic foundation that supports every part of the ecosystem without requiring any provider to change their core technology.

### Pillar 1: Sample to sequence provenance
Pillar 1 introduces semantic tracking of where a sample came from, how it was handled, and how the DNA was sequenced <a href="#ref1">[1]</a>.
This gives every genome a complete and traceable history, supporting clinical confidence, reproducibility, and long term research value.

### Pillar 2: Qualifying Variant framework for analysis variables
Pillar 2 provides a semantic data layer that separates the critical analysis variants from the internal pipeline <a href="#ref2">[2]</a>. 
This makes it possible to verify and compare results without exposing proprietary methods, allowing public and private organisations to contribute on equal terms while maintaining their own tools and infrastructure.

### Pillar 3: Evidence standard and interpretation layer
Pillar 3 creates a clear boundary between verifiable scientific evidence and the final result delivered by any service provider <a href="#ref3">[3]</a>.
It expresses this evidence in a simple, structured format that any end user can read, even when providers rely on proprietary or opaque tools.
This establishes a shared evidential foundation beneath the usual reports, which are often not interoperable.

### A shared national foundation
Together, the three pillars create a national scale framework grounded in open, verifiable standards.
They allow people, clinics, and services across Switzerland to rely on the same trusted decision process while supporting continued scientific progress and commercial innovation.

## How does this help Switzerland?

The three pillar ecosystem:

- gives every genome a traceable and reproducible history  
- separates analysis choices from the systems that implement them  
- provides a shared evidence and interpretation layer that every institution can verify  

This enables reliable, comparable genomic results across clinical care, national research efforts, and commercial services.

---

## Our goal

The SGA is focused on publishing the official guideline family that supports these pillars. Current drafts and releases are available on our 
[release page](https://www.swissgenomicsassociation.ch/releases/) <a href="#ref4">[4]</a>.

---

## References

<p id="ref1">[1] Eelke Van Der Horst, Deepak Unni, Femke Kopmels, Jan Armida, Vasundra Touré, Wouter Franke, Katrin Crameri, Elisa Cirillo, and Sabine Österle. Bridging Clinical and Genomic Knowledge: An Extension of the SPHN RDF Schema for Seamless Integration and FAIRification of Omics Data, December 2023.<br>
<a href="https://www.preprints.org/manuscript/202312.0373">Article</a> | <a href="https://www.preprints.org/frontend/manuscript/6d089babeb3de4497a0bcdd6b1696d04/download_pub">PDF</a> | <a href="doi.org/10.20944/preprints202312.0373.v1">DOI</a></p>

<p id="ref2">[2] Dylan Lawless, Ali Saadat, Mariam Ait Oumelloul, Simon Boutry, Veronika Stadler, Sabine Österle, Jan Armida, David Haerry, D. Sean Froese, Luregn J. Schlapbach, and Jacques Fellay. Application of qualifying variants for genomic analysis. May 2025. doi: 10.1101/2025.05.09.25324975.<br>
<a href="https://www.medrxiv.org/content/10.1101/2025.05.09.25324975">Article</a> | <a href="https://www.medrxiv.org/content/10.1101/2025.05.09.25324975v4.full.pdf">PDF</a> | <a href="https://doi.org/10.1101/2025.05.09.25324975">DOI</a></p>

<p id="ref3">[3] Swiss genomics association consensus guideline for evidence-based genomic variant interpretation in Mendelian disease. Draft guideline, Swiss Genomics Association, 2025. https://www.swissgenomicsassociation.ch/releases/.<br>
<a href="/pages/design_project_qv_evidence_flag">About</a> |
<a href="{{ '/assets/release/mendelian_disease_interpretation/latest/mendelian_disease_interpretation_v1.pdf' | relative_url }}" target="_blank">PDF (EN)</a> |
<a href="https://github.com/swissgenomicsassociation/mendelian_disease_interpretation">Repository</a></p>

<p id="ref4">[4] Swiss Genomics Association consensus guideline for verifiable genomic decision infrastructure. Draft guideline, Swiss Genomics Association, 2025.<br>
<a href="/pages/three_pillars">About (this page)</a> |
<a href="{{ '/assets/release/verifiable_infrastructure_pillars/latest/verifiable_infrastructure_pillars.pdf' | relative_url }}" target="_blank">PDF (EN)</a> |
<a href="https://github.com/swissgenomicsassociation/verifiable_infrastructure_pillars">Repository</a></p>

