---
title: "MAFₘₐₓ calculator"
date: 2025-10-25T00:00:01+10:00
layout: page
intro_image_hide_on_mobile: true
show_call_box: false
weight: 2
---

**Estimate the maximum minor allele frequency (MAF) your cohort can support.** A quick, transparent tool for setting MAF thresholds in human WGS cohort analysis.

<style>
  .maf-container {
    background: #fff;
    padding: 25px 30px;
    border-radius: 12px;
    max-width: 600px;
    box-shadow: 0 2px 6px rgba(0,0,0,0.05);
    margin: 30px auto;
  }
  .maf-container h2 { margin-top: 0; }
  .maf-container p, .maf-container li, .maf-container label {
    font-size: 0.95em;
    line-height: 1.5;
    color: #444;
  }
  .maf-container input[type="number"] {
    width: 100%;
    padding: 10px 12px;
    margin-top: 6px;
    border: 1px solid #ccc;
    border-radius: 6px;
    font-size: 1em;
    box-sizing: border-box;
    appearance: textfield;
  }
  .maf-container input[type="number"]::-webkit-inner-spin-button,
  .maf-container input[type="number"]::-webkit-outer-spin-button {
    margin: 0;
  }
  .maf-container label {
    margin-top: 16px;
    font-weight: 600;
    display: block;
  }
  .maf-container button {
    margin-top: 25px;
    padding: 10px 18px;
    background: #0069d9;
    color: white;
    border: none;
    border-radius: 6px;
    cursor: pointer;
    font-size: 1em;
  }
  .maf-container button:hover { background: #0053aa; }
  .maf-container pre {
    background: #f8f9fa;
    border: 1px solid #ddd;
    border-radius: 6px;
    padding: 10px;
    font-size: 0.9em;
    white-space: pre-wrap;
  }
  .maf-container .result {
    margin-top: 25px;
    font-size: 1.05em;
    background: #f1f3f5;
    padding: 12px;
    border-radius: 6px;
  }
  .maf-container .checkbox {
    margin-top: 18px;
    display: flex;
    align-items: center;
  }
  .maf-container .checkbox label {
    margin: 0 0 0 8px;
    font-weight: normal;
  }
</style>

  <!-- <h2>Maximum Allele Frequency (MAFₘₐₓ) calculator</h2> -->

  <p>
MAF filtering helps exclude common, likely benign variants so that analyses focus on rare, potentially disease-causing alleles.
    This calculator estimates the maximum MAF for a variant observed in a cohort.
    It assumes diploidy (2 alleles per individual) and allows you to specify:
  </p>
  <ul>
    <li><strong>Alternate alleles in patient(s):</strong> default 2 for a single case (1 if heterozygous, 2 if homozygous or recessive). Increase beyond 2 only if you have multiple affected individuals with the same phenotype.</li>
    <li><strong>Alternate alleles from parents:</strong> default 2 (if both carriers), 0 if parents are not in the cohort, and only increase beyond 2 if multiple parental carriers are included across shared families.</li>
  </ul>
  <p>
    The calculated <code>MAFₘₐₓ</code> can be used with <strong>PLINK</strong> or <strong>vcftools</strong> for filtering, for example:
  </p>
  <pre>
vcftools \
  --gzvcf ${vcf_file} \
  --max-maf ${qv_snvindel_v2_vcftoolsMAF_value} \
  --recode --recode-INFO-all \
  --out ${vcf_out}
  </pre>
<div class="maf-container">

  <label for="n_individuals">Total individuals in cohort</label>
  <input type="number" id="n_individuals" value="50" min="1">

  <label for="alt_proband">Alternate alleles in patient(s)</label>
  <input type="number" id="alt_proband" value="2" min="0" max="10">

  <label for="alt_parents">Alternate alleles from parents (0 if parents not in cohort)</label>
  <input type="number" id="alt_parents" value="2" min="0" max="10">

  <div class="checkbox">
    <input type="checkbox" id="include_one_more" checked>
    <label for="include_one_more">
      Add one extra allele (for tools that use strict “less than” filtering).
    </label>
  </div>
  <p style="font-size:0.9em; color:#666; margin-top:5px;">
    Some tools (like certain versions of vcftools or PLINK) exclude variants exactly matching the MAF threshold.
    Tick this box to add a small margin (+1 allele) so that variants at the boundary are included.
  </p>

  <button onclick="calculateMAF()">Calculate</button>

  <div class="result" id="result"></div>
</div>

<script>
  function calculateMAF() {
    const nIndividuals = parseFloat(document.getElementById('n_individuals').value);
    const altProband = Math.min(Math.max(parseFloat(document.getElementById('alt_proband').value), 0), 100);
    const altParents = Math.min(Math.max(parseFloat(document.getElementById('alt_parents').value), 0), 100);
    const includeExtra = document.getElementById('include_one_more').checked;

    const nAlleles = nIndividuals * 2;
    let altAlleles = altProband + altParents;
    if (includeExtra) altAlleles += 1;

    const mafMax = altAlleles / nAlleles;
    const mafPercent = mafMax * 100;

    const hetPercent = Math.min((altAlleles / nIndividuals) * 100, 100);
    const homPercent = Math.min((altAlleles / 2 / nIndividuals) * 100, 100);

    document.getElementById('result').innerHTML = `
      <div style="margin-bottom:12px;">
      <strong>Result:</strong><br>
        Maximum allele frequency (MAFₘₐₓ):
        <button id="copyBtn" onclick="copyMAF('${mafMax.toFixed(6)}')" 
          style="margin-left:8px; padding:6px 10px; border:none; border-radius:5px; background:#007bff; color:white; cursor:pointer; font-size:0.95em;">
          ${mafMax.toFixed(6)}
        </button>
        <span id="copyMsg" style="color:green; font-size:0.9em; display:none; margin-left:8px;">copied!</span>
      </div>
      <strong>Summary:</strong><br>
      Total alleles in cohort: ${nAlleles}<br>
      Total alternate alleles observed (with adjustment): ${altAlleles}<br>
      MAF as percentage of all alleles: <strong>${mafPercent.toFixed(2)}%</strong><br>
      Estimated carrier percentage (heterozygous): <strong>${hetPercent.toFixed(2)}%</strong><br>
      Estimated carrier percentage (homozygous): <strong>${homPercent.toFixed(2)}%</strong><br><br>
      Example usage:<br>
      <pre style="margin-top:10px;">
vcftools \\
  --gzvcf input.vcf.gz \\
  --max-maf ${mafMax.toFixed(6)} \\
  --recode --recode-INFO-all \\
  --out filtered_output
      </pre>
    `;
  }

  function copyMAF(value) {
    navigator.clipboard.writeText(value);
    const msg = document.getElementById('copyMsg');
    msg.style.display = 'inline';
    setTimeout(() => { msg.style.display = 'none'; }, 1500);
  }
</script>



<hr style="margin:40px 0;">

<h2>Why is this used?</h2>

<p>
Filtering by <strong>minor allele frequency (MAF)</strong> or <strong>allele frequency (AF)</strong> is a standard step in whole genome sequencing (WGS) analysis. Cohorts are used because combining samples provides internal frequency context and improves quality control. Even when analysing single cases, they are often grouped into cohorts, either because they share a disease phenotype or because their data were processed together in the same sequencing batch.
</p>

<p>
This approach separates rare, likely causal variants from common variants that are usually benign. Each individual carries thousands of variants, so frequency filtering reduces false positives and improves interpretation. A MAF of <code>0.01</code> means that the alternate allele appears in about 1% of all alleles in the cohort, which corresponds to roughly 10% of individuals if everyone is heterozygous. This helps identify whether a variant is truly rare or widespread in the population.
</p>

<p>
Many pipelines process cohort data jointly to detect shared artefacts or systematic sequencing errors before filtering down to individual patient results. Common tools that apply or interpret MAF filters include <strong>GATK</strong>, <strong>BCFtools</strong>, <strong>VCFtools</strong>, and <strong>PLINK</strong> for genome-wide association studies (GWAS). Filtering ensures that downstream analyses, whether statistical, Bayesian, or clinical, are based on realistic population frequencies rather than being influenced by common, neutral variation.
</p>

<h3>Related methods</h3>
<p>
The cohort-level MAF calculation above provides the simplest frequency-based filter. Other approaches use additional data or internal computations within analysis tools:
</p>
<ul>
  <li>
    <strong>External population filters</strong> – use public datasets such as gnomAD or TOPMed to exclude globally common variants.<br>
    <code>bcftools filter -e 'INFO/gnomAD_AF >= 0.01' input.vcf.gz -Oz -o filtered.vcf.gz</code>
  </li>
  <li>
    <strong>Case–control frequency testing</strong> – compare allele frequencies between affected and unaffected groups.<br>
    <code>plink --bfile cohort --pheno phenotype.txt --assoc</code>
  </li>
  <li>
    <strong>Call-rate adjusted MAF</strong> – correct for missing genotypes when some samples lack calls.<br>
    <code>MAF = alt_alleles / (2 * n_called_individuals)</code>
  </li>
  <li>
    <strong>Population- or ancestry-stratified MAF</strong> – compute subgroup-specific frequencies for population structure or batch QC.<br>
    <code>bcftools +fill-tags input.vcf.gz -- -t AF,AC,AN -S ancestry_groups.txt</code>
  </li>
  <li>
    <strong>Theoretical MAF thresholds</strong> – estimate the maximum credible frequency for pathogenic variants based on disease prevalence and inheritance model.<br>
    <code>MAF_max = prevalence × (1 / penetrance) × (1 / genetic_heterogeneity)</code>
  </li>
</ul>
<p>
These methods extend simple cohort-level frequency filtering and are implemented internally in tools such as <strong>GATK</strong>, <strong>BCFtools</strong>, <strong>VCFtools</strong>, and <strong>PLINK</strong> depending on study design.
</p>

