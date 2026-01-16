---
title: Evidence Ratio Reporting Standard
layout: page
description: ERRS standard
math: mathjax
---

Swiss Genomics Association  
2026

---

**Version 1.0**  
**Standard identifier**: SGA-ERRS-1.0\\
This document defines a normative reporting standard published by the Swiss Genomics Association.

## 1. Introduction

Statistical results are increasingly stored, compared, and reused in databases and analytic platforms rather than read only through journal articles. In these settings, results from different analyses must be reported in a consistent and self contained way to support comparison and reproducibility.

The Evidence Ratio Reporting Standard (ERRS) defines a reporting completeness standard for statistical evidence derived from likelihood based analyses. Its purpose is to specify the minimal set of quantities and metadata that **MUST** be reported whenever an evidence ratio is reported.

This standard applies only once an evidence ratio has been chosen as a reporting quantity and does not require, recommend, or encourage the use of evidence ratios in any analysis. ERRS standardises reporting requirements only. It does not define analytical methods, modelling choices, inferential procedures, or decision rules.

The ERRS is designed to support structured, interoperable representation of statistical evidence across heterogeneous analyses, suitable for use in databases, registries, and analytic systems linked to electronic health record infrastructures.

---

## 2. Scope

This standard governs reporting requirements only and applies exclusively to analyses that already report an evidence ratio.

### 2.1 In scope

The ERRS defines:

- the normative definition of an evidence ratio report  
- the required components that **MUST** accompany any reported evidence ratio  
- minimal coherence constraints between reported components  
- minimal integrity and provenance requirements  

### 2.2 Out of scope

The ERRS does not define:

- how statistical models are constructed or selected  
- how null or alternative models are chosen  
- how reported quantities should be interpreted  
- thresholds, classifications, or decision criteria  
- clinical, scientific, or regulatory conclusions  

---

## 3. Terminology and conventions

The key words **MUST**, **MUST NOT**, **SHOULD**, and **MAY** are to be interpreted as described in RFC 2119.

An **analysis** is a statistical procedure applied to observed data that yields one or more model based quantities.

A **model** is a statistical specification defining how observed data are generated.

A **null model** represents a specified reference model, typically encoding absence of an effect or association.

An **alternative model** represents a specified model distinct from the null model.

An **effect estimate** is a scalar quantity summarising a parameter or function of parameters of interest under a specified model.

An **uncertainty interval** is an interval estimate associated with an effect estimate, reflecting uncertainty under a specified inferential framework.

An **evidence ratio** is a ratio of likelihoods or marginal likelihoods comparing two specified models for the observed data.

---

## 4. Definition of an evidence ratio report

An **evidence ratio report** is the normative reporting object defined by this standard.

An evidence ratio report is a structured report instance that contains a set of quantities derived from a single analysis and dataset, including an evidence ratio and its required accompanying information.

This standard does not define the interpretation or use of an evidence ratio report. It defines only the information that **MUST** be present for reporting to be compliant.

---

## 5. Required components

Each evidence ratio report **MUST** include the following components, all derived from the same statistical model and dataset:

- an effect estimate  
- an uncertainty interval corresponding to that estimate  
- a likelihood based evidence ratio, reported on the log$$_{10}$$ scale  
- an explicit definition of the null model  
- an explicit definition of the alternative model  

No ordering or priority is implied by this list. 
A report that omits any of these components is not compliant with this standard.

---

## 6. Component definitions

### 6.1 Effect estimate

The effect estimate **MUST** be a scalar quantity derived from the specified model. 
The method used to obtain the effect estimate **MUST** be stated or be unambiguous from context. 
The scale and parameterisation of the effect estimate **MUST** be stated or be unambiguous from context. 

### 6.2 Uncertainty interval

The uncertainty interval **MUST** correspond to the reported effect estimate. 
The interval level or credibility definition **MUST** be stated. 
The method used to construct the uncertainty interval **MUST** be stated. 
The uncertainty interval **MUST** be derived from the same statistical model and data as the effect estimate.

Examples include, but are not limited to, confidence intervals, credible intervals, and likelihood based intervals.

### 6.3 Evidence ratio

Let $$x$$ denote the observed data. 
Let $$m_0(x)$$ denote the likelihood or marginal likelihood of the data under the null model. 
Let $$m_1(x)$$ denote the likelihood or marginal likelihood of the data under the alternative model.

The evidence ratio is defined as:

$$
E(x) = \frac{m_1(x)}{m_0(x)}.
$$

The evidence ratio **MUST** be reported on a logarithmic scale. 
By default, the log$$_{10}$$ scale **MUST** be used and **SHOULD** be preferred for tabular and comparative reporting.
The raw evidence ratio **MAY** be reported in addition to the logarithmic form. 
If an alternative logarithmic base or the raw evidence ratio is reported, the scale and transformation **MUST** be stated explicitly.
The evidence ratio **MUST** be derived from the same data and model specifications as the reported effect estimate and uncertainty interval.

---

## 7. Coherence requirements

All components of an evidence ratio report **MUST** be derived from internally consistent modelling assumptions.

The effect estimate, uncertainty interval, and evidence ratio **MUST** correspond to the same model specification and dataset.

If likelihoods are maximised over parameters, this **MUST** be stated.
If likelihoods are marginalised over parameters, this **MUST** be stated.

---

## 8. Integrity and provenance

An ERRS compliant report **MUST** include or reference sufficient information to allow independent reproduction of the reported quantities.

At a minimum, the report **MUST** specify:

- the statistical model used  
- the null model definition  
- the alternative model definition  
- whether likelihoods are maximised or marginalised  

---

## 9. Non goals

This standard does not define how evidence ratio reports should be interpreted, combined, or used for inference or decision making.

The standard does not assign meaning, strength, or sufficiency to any reported quantity.

---

## 10. Examples (informative)

This section provides non normative examples illustrating how evidence ratio reports may be presented in practice. The examples demonstrate compliance with this standard across distinct and widely used classes of biomedical statistical analysis. No interpretation, thresholding, or inferential guidance is implied.

### 10.1 Single analysis report

*Example of a single evidence ratio report.*

<table>
  <thead>
    <tr>
      <th><strong>Component</strong></th>
      <th><strong>Reported value</strong></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>Effect estimate</td>
      <td>$$-0.59$$</td>
    </tr>
    <tr>
      <td>Uncertainty interval (95%)</td>
      <td>$$[-1.26,\;0.08]$$</td>
    </tr>
    <tr>
      <td>Evidence ratio</td>
      <td>$$\log_{10} E(x) = 0.17$$</td>
    </tr>
    <tr>
      <td>Null model</td>
      <td>No treatment effect</td>
    </tr>
    <tr>
      <td>Alternative model</td>
      <td>Non zero treatment effect</td>
    </tr>
    <tr>
      <td>Model specification</td>
      <td>Linear regression with Gaussian errors</td>
    </tr>
  </tbody>
</table>


### 10.2 Multiple analyses reported using a common schema

*Example of multiple evidence ratio reports across heterogeneous analyses.*

<table>
  <thead>
    <tr>
      <th><strong>Analysis type</strong></th>
      <th><strong>Effect estimate</strong></th>
      <th><strong>Uncertainty interval (95%)</strong></th>
      <th><strong>$$\log_{10} E(x)$$</strong></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>Linear regression<br><em>treatment effect on continuous outcome</em></td>
      <td>$$-0.59$$</td>
      <td>$$[-1.26,\;0.08]$$</td>
      <td>$$0.17$$</td>
    </tr>
    <tr>
      <td>One sample mean test<br><em>mean difference from zero</em></td>
      <td>$$0.39$$</td>
      <td>$$[0.18,\;0.59]$$</td>
      <td>$$3.05$$</td>
    </tr>
    <tr>
      <td>Two sample mean test<br><em>difference between treatment groups</em></td>
      <td>$$-1.32$$</td>
      <td>$$[-1.77,\;-0.88]$$</td>
      <td>$$14.42$$</td>
    </tr>
    <tr>
      <td>Binary outcome association<br><em>2x2 contingency table</em></td>
      <td>$$0.48$$</td>
      <td>$$[-0.13,\;1.09]$$</td>
      <td>$$0.52$$</td>
    </tr>
    <tr>
      <td>Regression coefficient<br><em>continuous exposure</em></td>
      <td>$$-5.73$$</td>
      <td>$$[-6.59,\;-4.88]$$</td>
      <td>$$18.61$$</td>
    </tr>
    <tr>
      <td>Time to event analysis<br><em>accelerated failure time model</em></td>
      <td>$$-0.27$$</td>
      <td>$$[-0.57,\;0.03]$$</td>
      <td>$$0.65$$</td>
    </tr>
    <tr>
      <td>Survival analysis<br><em>Cox proportional hazards model</em></td>
      <td>$$0.96$$</td>
      <td>$$[0.64,\;1.28]$$</td>
      <td>$$7.50$$</td>
    </tr>
  </tbody>
</table>


---

## 11. Versioning

This document defines **ERRS version 1.0**.  
Future revisions **MUST** preserve the definitions and reporting semantics specified herein.

