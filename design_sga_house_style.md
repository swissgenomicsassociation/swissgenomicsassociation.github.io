# Swiss Genomics Association

## house style and design guide for standards

This document defines the house style, structure, and design principles used by the Swiss Genomics Association (SGA) when crafting normative standards.

It exists to ensure that all SGA standards are:

* immediately understandable on first reading
* precise and unambiguous
* readable by humans and machines
* safe for copy, reuse, and automated processing
* consistent across domains and over time

This guide is binding for all new SGA standards and for revisions of existing ones.

---

## 1. purpose of SGA standards

SGA standards define **representations**, **schemas**, or **reporting requirements**.

They do not:

* argue for scientific positions
* introduce new methods
* provide interpretation or decision rules
* persuade or advocate

An SGA standard answers only:

> *If this object exists, how must it be represented?*

---

## 2. target audience

Every SGA standard must be readable by all of the following groups without translation or specialist background knowledge:

* clinicians
* statisticians
* data scientists and data engineers
* clinical trialists
* regulators and auditors

Language and structure must assume:

* high intelligence
* limited time
* frequent skimming

---

## 3. language rules

### 3.1 tone and style

SGA standards must use language that is:

* formal but not academic
* neutral and descriptive
* non persuasive
* non rhetorical

Do not use:

* metaphors
* motivational language
* claims of improvement or superiority
* claims of correctness or optimality

Standards must say what is **defined**, not what is **better**.

### 3.2 normative keywords

The words **MUST**, **MUST NOT**, **SHOULD**, and **MAY** are reserved and must be used only with the meanings defined in RFC 2119.

Rules:

* Use **MUST** only for hard requirements.
* Do not use **SHOULD** to soften mandatory requirements.
* Do not place normative keywords inside explanatory prose.

---

## 4. document structure

All SGA standards ideally follow this section order unless there is a strong reason not to.

1. Introduction
2. Scope
   * In scope
   * Out of scope
3. Terminology and conventions
4. Core definitions or data model
5. Requirements
6. Integrity and provenance
7. Examples (informative)
8. Non goals or interpretation
9. Versioning

The section titles must be explicit and literal. Creative titles are not permitted.

---

## 5. prose versus lists

### 5.1 when to use prose

Use prose for:

* motivation
* context
* explanation
* examples

Prose paragraphs must:

* be short, typically 2 to 3 sentences
* contain one idea only
* avoid compound or nested clauses

### 5.2 when to use lists

Use lists for:

* requirements
* definitions
* components
* metadata fields
* mappings or rules

Rules for lists:

* each item must be a complete statement
* do not explain philosophy inside lists
* do not mix requirements with explanation

---

## 6. examples policy

Examples are **informative**, not normative.

Every SGA standard must include:

* one simple example using a familiar setting
* optionally, one heterogeneous example showing generality

Rules for examples:

* examples must resemble real clinical or research practice
* toy or abstract examples are not permitted
* examples must not introduce new rules
* examples must not argue for adoption

Good examples include:

* linear regression in a clinical trial
* simple contingency tables
* clearly named rules or fields

---

## 7. formatting and layout rules

### 7.1 layout

* Single column layout only.
* No page numbers.
* No marginal notes or sidebars.
* No footnotes.

Two column layouts are prohibited due to copy and parsing errors.

### 7.2 paragraphs and line breaks

* Do not force line breaks inside phrases.
* Avoid narrow columns that cause awkward wrapping.
* Prefer natural paragraph flow.

### 7.3 equations

* Equations must be isolated on their own lines.
* Do not embed equations inside sentences where avoidable.

---

## 8. tables

Tables must be:

* simple
* shallow
* readable when copied as plain text

Rules:

* avoid nested tables
* avoid excessive column compression
* column headers must be explicit
* tables must make sense without surrounding prose

---

## 9. AI readability and copy safety

SGA standards are designed to be read by both humans and AI systems.

To ensure safe reuse:

* avoid complex LaTeX macros
* avoid custom commands where possible
* keep identifiers and definitions on single lines
* avoid decorative formatting
* avoid inline references that break sentence flow

The goal is that a standard can be copied, pasted, indexed, and re rendered without loss of meaning.

---

## 10. source format and publication workflow

SGA standards must be authored from a **single canonical source** that is used to produce both human readable and machine readable outputs.

Historically, LaTeX has been used to enforce disciplined layout and to avoid PDF parsing errors. Other single source approaches MAY be used, provided they satisfy the requirements below.

### requirements

* A standard MUST have one authoritative source document.
* From this source, both PDF and HTML representations MUST be generated.
* The PDF and HTML versions MUST be content identical.
* Differences in layout or styling are permitted.
* Differences in wording, structure, ordering, or meaning are not permitted.

### format guidance

* LaTeX remains preferred where it simplifies control of layout and avoids copy and parsing errors.
* Markdown is preferred for direct HTML publication and reuse.
* HTML to PDF workflows are permitted but uncommon and MUST be validated carefully.

### conversion rules

* Automatic conversion between formats is permitted only if it preserves content exactly.
* No format may introduce or omit content relative to the canonical source.
* All published representations of an SGA standard are normative and must be kept in sync.

---

## 11. consistency across standards

All SGA standards must share:

* identical opening metadata structure
* identical versioning language
* consistent terminology
* consistent use of normative keywords

Changes to house style apply prospectively and must not silently alter existing standards.

Examples:

example 1: opening block
```
**Evidence Ratio Reporting Standard**  
Swiss Genomics Association  
Version 1.0  
Standard identifier: SGA-ERRS-1.0  

This document defines a normative reporting standard published by the Swiss Genomics Association.
```

example 2: introduction style
```
## Introduction

Statistical results are increasingly stored and reused in databases rather than read only through journal articles. In these settings, results must be reported in a consistent and self contained way.

This standard defines the minimal information that MUST be reported whenever an evidence ratio is reported. It governs reporting only and does not define analysis methods, interpretation, or decision rules.
```


example 3: requirements list
```
Each report MUST include:

an effect estimate
* an uncertainty interval
* an explicit definition of the null model
```

---

## 12. versioning philosophy

* Standards are versioned explicitly.
* Backward compatibility must be preserved unless stated otherwise.
* Semantic meaning must not change across versions without a version increment.

---

## 13. final principle

An SGA standard should read as if it were written for:

* a careful human reader
* a strict regulator
* an automated system

If any one of these cannot understand the document on first reading, the standard is not yet finished.

