# Unsupervised Analysis of Road Incidents

**ISCTE**
**Unsupervised Learning Methods**
**2025/2026**

## Project Scope

This project aims to apply techniques from the **Unsupervised Learning Methods** course to a road incident database.
The main focus was to identify patterns and segment the incidents into distinct profiles without using a pre-defined target variable.

The analysis allowed transforming complex claims data into actionable information, identifying risk groups based on financial, demographic, and contractual characteristics.

## Developed by:

| Name | Student ID |
|------|------------|
| Daniel Fonseca | 125158 |
| Francisco Gonçalves | 130649 |
| João Filipe | 130665 |
| Guilherme Pires | 131658 |

## Methodology

The workflow was developed in **R** and consisted of the following stages:

1.  **Data Pre-processing:**
    * Data cleaning.
    * Variable selection.
    * Final sample size: 907 observations and 24 variables.

2.  **Principal Component Analysis (PCA):**
    * **Selection:** 2 Components retained based on the *Scree Plot*.
    * **Identified Dimensions:**
        * *PC1 - Claim Severity* (Financial severity and complexity).
        * *PC2 - Customer Maturity* (Age and tenure).

3.  **Clustering (K-Means):**
    * Data segmentation based on PCA scores.
    * Identification of 3 distinct clusters.

## Key Results

The analysis identified three main accident profiles:

* **Group 1: High-Risk Loyal Seniors**
    * Customers with a long contractual relationship and advanced age.
    * Involved in high-cost collisions with a high "Total Loss" rate.
    * Predominantly female.

* **Group 2: Low-Risk Customers (Minor Incidents)**
    * Low monetary value claims.
    * Exclusive typologies: Theft and parking accidents.
    * Trivial damages.

* **Group 3: High-Risk Youth**
    * Younger customers with shorter history in the company.
    * Very high financial severity (similar to Seniors), but with fewer catastrophic cases.
    * Focus on multi-vehicle collisions.
