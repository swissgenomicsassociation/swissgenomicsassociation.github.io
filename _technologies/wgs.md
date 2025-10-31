<!-- --- -->
<!-- title: "WGS analysis" -->
<!-- date: 2025-01-01T00:00:01+10:00 -->
<!-- weight: 1 -->
<!-- --- -->

The Whole Genome Sequencing (WGS) analysis system efficiently processes raw FASTQ data through alignment, variant calling, and detailed annotation.

![WGS analysis](/images/freepik_vectorjuice/gene-therapy-abstract-concept-vector-illustration-genetic-cancer-treatment-genes-transfer-therapy-regenerative-medicine-experimental-approach-oncology-prevent-disease-abstract-metaphor_335657-1613-2.jpg)

The Whole Genome Sequencing (WGS) analysis system is a comprehensive pipeline designed for the processing of raw FASTQ data through to alignment, variant calling, and detailed annotation. 
This system integrates advanced bioinformatics tools and databases to deliver accurate genomic interpretations.

**Key Phases of the WGS Analysis System:**

1. **Data Processing:** Initial handling of raw sequencing data, involving quality control and preparation for downstream analyses. This stage ensures that data integrity is maintained for reliable results.

2. **Alignment to Reference Genome:** Sequencing reads are aligned to a reference genome using sophisticated competing algorithms. We compare and benchmark to rely on the best precision. This crucial step forms the foundation for accurate variant identification. We rely on BWA-MEM2.

3. **Variant Calling:** Post-alignment, the pipeline identifies genomic variants such as SNVs (single nucleotide variants) and INDELs (insertions and deletions). This process allows us to distinguish between true variants and sequencing errors.

4. **Annotation and Classification:** Variants are annotated using databases like dbSNFP and annotation tools such as Variant Effect Predictor (VEP), ANNOVAR, and Nirvana. This step enriches variant data with information about potential biological impacts of SNVs, MNVs, insertions, deletions, indels, and SVs (including CNVs).

5. **Variant Filtering and Interpretation:** Employing stringent filters and ACMG/AMP guidelines, the system classifies variants based on their pathogenic potential. This involves assessing evidence from multiple sources, ensuring a robust evaluation of each variant. **Guru** is specialised for this stage.

6. **Report Generation:** The final stage involves compiling the interpreted data into comprehensive reports. These reports provide insights into the genomic landscape, supporting clinical decision-making and research studies. **Heracles** is specialised for this stage.

This WGS analysis system is crucial for translating complex genomic data into actionable medical insights, enabling personalised medicine and advancing genetic discovery.

