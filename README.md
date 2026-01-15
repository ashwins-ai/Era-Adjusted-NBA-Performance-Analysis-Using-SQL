# Era-Adjusted-NBA-Performance-Analysis-Using-SQL
## Overview

This repository contains a SQL-first analytical study of NBA player performance across historical eras and competitive contexts.  
The project focuses on **normalizing player statistics for league-level structural change**, validating those metrics under competitive stress (playoffs), evaluating signal reliability (preseason), and aggregating results into **career-level dominance and robustness indicators**.

All data transformations, aggregations, and statistical measures are implemented **exclusively in MySQL**.

---

## Objectives

- Construct league-level baselines to capture season-specific scoring environments
    
- Normalize player performance for cross-era comparability
    
- Evaluate how player performance translates from regular season to playoffs
    
- Quantify preseason performance noise relative to real competition
    
- Distinguish peak dominance from long-term consistency and adaptability
    

---

## Data Scope

**Granularity:** Player–Season

**Competition Types:**

- `REGULAR`
    
- `PLAYOFF`
    
- `PRESEASON`
    

**Core Tables:**

- `reg_raw` – regular season player statistics
    
- `off_raw` – playoff player statistics
    
- `pre_raw` – preseason player statistics
    

Raw data was ingested from the NBA Stats API and loaded into MySQL staging tables before normalization via views.

---

## Methodology

### 1. League Baseline Construction

League-wide per-season baselines were computed using regular-season data, including:

- Average points per game (PPG)
    
- Three-point percentage (FG3%)
    
- Three-point attempt rate (3PA / FGA)
    

Seasons were grouped into three empirically motivated eras (`ERA_1`, `ERA_2`, `ERA_3`) based on observed structural shifts in offensive profiles.

---

### 2. Era-Adjusted Player Metrics

Player performance was normalized relative to season baselines using era-adjusted indices:

- `ppg_idx`
    
- `rpg_idx`
    
- `apg_idx`
    

These indices represent **relative performance within the scoring environment of a given season**, enabling valid comparisons across eras.

---

### 3. Playoff Translation Analysis

Playoff performance was evaluated **relative to regular-season baselines**, not playoff baselines, to measure how performance changes under increased competitive pressure.

Metrics analyzed:

- Mean playoff translation (playoff index − regular index)
    
- Variance by era
    
- Stability by playoff games played
    
- Regular-to-playoff correlation
    

---

### 4. Preseason Signal Reliability

Preseason performance was aligned to the corresponding regular season and normalized using the same league baselines.  
Prediction error and variance were analyzed to quantify preseason noise relative to both regular season and playoff performance.

---

### 5. Career-Level Aggregation

Career summaries were constructed using era-adjusted metrics:

- `weighted_dom_idx` – career-weighted dominance
    
- `peak_dom` – maximum single-season dominance
    
- `dom_volatility` – variability across seasons
    
- `eras_played` – adaptability across league regimes
    

---

## Key Findings

### League Structure

- Average per-player scoring increased by ~10% from early eras to the modern era.
    
- Three-point attempt rate increased by over **100%**, indicating that league evolution is driven primarily by **shot selection**, not proportional increases in individual dominance.
    
- Era normalization is therefore required for cross-era player evaluation.
    

---

### Playoff Performance

- Playoffs impose a consistent negative performance shift across all eras.
    
- Era-adjusted regular-season performance explains the majority of playoff performance variance.
    
- Regular-to-playoff correlations are very high (≈0.9), indicating that playoffs largely preserve relative player ordering.
    
- Playoffs function primarily as a **level shift**, not a reordering mechanism.
    

---

### Preseason Performance

- Preseason performance exhibits substantially higher variance than playoff performance.
    
- Even high-sample preseason data is less reliable than limited playoff samples.
    
- Preseason-to-regular correlations are materially lower than regular-to-playoff correlations.
    
- Preseason metrics contain signal but should be heavily discounted in decision-making contexts.
    

---

### Career Evaluation

- Peak dominance and career robustness are distinct dimensions.
    
- Some players exhibit high single-season peaks with high volatility, while others demonstrate sustained dominance with low variability.
    
- Era survivability highlights adaptability across fundamentally different league environments, independent of raw totals.
    

---

## Conclusions

- Raw box-score comparisons across eras are analytically misleading without normalization.
    
- Era-adjusted regular-season metrics provide the most reliable baseline for player evaluation.
    
- Playoff data validates these metrics under stress rather than overturning them.
    
- Preseason data is structurally noisy and weakly predictive.
    
- Long-term evaluation requires separating peak performance, consistency, and adaptability.
    

---

## Technical Notes

- All computations executed in **MySQL**
    
- No machine learning models or external statistical tools
    
- Pearson correlations implemented manually using SQL aggregates
    
- Emphasis on schema design, aggregation correctness, and validation
    

---

## Potential Extensions

- Role- or usage-adjusted baselines
    
- Team-context normalization
    
- Shrinkage methods for small samples
    
- Player archetype clustering
    
- Decision-support simulations for roster evaluation
    

---

## Reproducibility

All results are derived from deterministic SQL views and queries.  
Given the same input data, outputs are fully reproducible.
