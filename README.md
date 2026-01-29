# Era-Adjusted NBA Player Performance Analysis (MySQL)
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
SQL-first analysis of NBA player performance across eras, validating metrics under playoff stress and evaluating preseason signal reliability.

## Key Results

| Metric | Regular → Playoff | Preseason → Regular |
|------|------------------:|--------------------:|
| Correlation (PPG) | **0.91** | **0.73** |
| Std Dev (Error) | **0.29** | **0.40** |

### Top Career Dominance

| player_name   | seasons_played | career_gp | weighted_dom_idx | peak_dom | dom_volatility |
| ------------- | -------------: | --------: | ---------------: | -------: | -------------: |
| Luka Dončić   |              7 |       450 |             2.66 |     3.06 |           0.28 |
| LeBron James  |             22 |      1562 |             2.62 |     2.91 |           0.18 |
| Nikola Jokić  |             10 |       745 |             2.41 |     3.12 |           0.54 |
| Stephen Curry |             15 |      1021 |             2.20 |     2.64 |           0.26 |
| Kevin Durant  |             17 |      1123 |             2.24 |     2.72 |           0.26 |

## Core Conclusion
Era-adjusted regular-season metrics are highly stable under playoff conditions, while preseason performance is substantially noisier and should be heavily discounted.

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
## Overview

This repository contains a **SQL-first analytical study** of NBA player performance across historical eras and competitive contexts. The analysis constructs **era-normalized performance metrics**, validates them under competitive stress (playoffs), evaluates **signal reliability** (preseason), and aggregates results into **career-level dominance and robustness indicators**.

All transformations, aggregations, and statistical measures are implemented **exclusively in MySQL**.

---

## Data Scope

**Granularity:** Player–Season

**Competition Types**

* Regular Season (`REGULAR`)
* Playoffs (`PLAYOFF`)
* Preseason (`PRESEASON`)

**Core Tables**

* `reg_raw` - regular season player statistics
* `off_raw` - playoff player statistics
* `pre_raw` - preseason player statistics

Raw datasets were ingested via CSV into MySQL staging tables and normalized through SQL views.

---

## Analytical Design

### 1. League Baseline Construction

League-wide per-season baselines were computed from regular-season data to capture the scoring environment for each season.

**Baselines**

* Average points per game (PPG)
* Three-point percentage (FG3%)
* Three-point attempt rate (3PA / FGA)

Seasons were grouped into three empirically observed eras:

* `ERA_1`
* `ERA_2`
* `ERA_3`

---

### League Era Baselines

| era   | era_avg_ppg | era_avg_fg3p | era_avg_3pt_rate |
| ----- | ----------: | -----------: | ---------------: |
| ERA_1 |        9.60 |        0.231 |            0.166 |
| ERA_2 |        9.83 |        0.246 |            0.215 |
| ERA_3 |       10.55 |        0.309 |            0.361 |

---

### Era-to-Era Structural Change

| Metric              | ERA_1 → ERA_2 | ERA_2 → ERA_3 | ERA_1 → ERA_3 |
| ------------------- | ------------: | ------------: | ------------: |
| PPG change (%)      |          2.35 |          7.39 |          9.92 |
| 3PT rate change (%) |         29.53 |         67.84 |        117.41 |

**Interpretation**

Scoring inflation is modest, while shot selection changes are substantial.
Era normalization is therefore required for valid cross-era player comparison.

---

## Era-Adjusted Player Metrics

For each player-season, era-adjusted indices were computed using league baselines:

* `ppg_idx`
* `rpg_idx`
* `apg_idx`

These indices represent **relative performance within the season’s scoring environment**, enabling cross-era comparability without relying on raw box-score totals.

---

## Playoff Translation Analysis

### Objective

Determine whether playoffs meaningfully reorder player quality or primarily impose a performance level shift.

**Dataset Size**

* 3,962 player-seasons
* 1,160 players
* 42,349 playoff games

---

### Playoff Translation Summary (PPG)

| era   | mean_ppg_tr | sd_ppg_tr |
| ----- | ----------: | --------: |
| ERA_1 |      -0.080 |     0.283 |
| ERA_2 |      -0.088 |     0.294 |
| ERA_3 |      -0.109 |     0.300 |

---

### Regular → Playoff Correlation

| Metric | Correlation |
| ------ | ----------: |
| PPG    |       0.916 |
| RPG    |       0.880 |
| APG    |       0.920 |

**Conclusion**

Playoffs reduce absolute output but largely preserve relative player ordering.
They function as a **level shift**, not a ranking reshuffle.

---

### Playoff Stability by Sample Size

| gp_bucket | row_cnt | sd_ppg_tr |
| --------- | ------: | --------: |
| LOW_GP    |   1,982 |     0.317 |
| MID_GP    |   1,980 |     0.268 |

Variance decreases with exposure, confirming metric stability.

---

## Preseason Signal Reliability

### Objective

Quantify preseason performance noise relative to regular-season output.

---

### Preseason Error Distribution (PPG)

| era   | mean_ppg_err | sd_ppg_err |
| ----- | -----------: | ---------: |
| ERA_2 |       -0.078 |      0.403 |
| ERA_3 |       -0.103 |      0.403 |

---

### Preseason → Regular Correlation

| Metric | Correlation |
| ------ | ----------: |
| PPG    |        0.73 |

---

### Preseason Stability by Sample Size

| gp_bucket | row_cnt | sd_ppg_err |
| --------- | ------: | ---------: |
| LOW_GP    |   1,049 |      0.447 |
| MID_GP    |   5,171 |      0.397 |
| HIGH_GP   |     673 |      0.354 |

**Conclusion**

Preseason metrics exhibit materially higher variance than playoff metrics, even at higher sample sizes.

---

## Career-Level Dominance Metrics

Career summaries were constructed using era-adjusted indices.

**Metrics**

* `weighted_dom_idx` - career-weighted dominance
* `peak_dom` - maximum single-season dominance
* `dom_volatility` - variability across seasons

---

### Top Career Dominance

| player_name   | seasons_played | career_gp | weighted_dom_idx | peak_dom | dom_volatility |
| ------------- | -------------: | --------: | ---------------: | -------: | -------------: |
| Luka Dončić   |              7 |       450 |             2.66 |     3.06 |           0.28 |
| LeBron James  |             22 |      1562 |             2.62 |     2.91 |           0.18 |
| Nikola Jokić  |             10 |       745 |             2.41 |     3.12 |           0.54 |
| Stephen Curry |             15 |      1021 |             2.20 |     2.64 |           0.26 |
| Kevin Durant  |             17 |      1123 |             2.24 |     2.72 |           0.26 |

---

## Era Survivability

Players evaluated on adaptability across league regimes.

### Players Active in All Eras

| player_name   | eras_played | seasons_played | career_gp |
| ------------- | ----------: | -------------: | --------: |
| LeBron James  |           3 |             22 |      1562 |
| Dirk Nowitzki |           3 |             21 |      1522 |
| Kevin Garnett |           3 |             20 |      1382 |
| Tim Duncan    |           3 |             19 |      1392 |
| Kobe Bryant   |           3 |             19 |      1340 |
| Dwyane Wade   |           3 |             16 |      1054 |
| Manu Ginóbili |           3 |             16 |      1057 |

---

## Key Findings

* League scoring increased modestly; shot selection changed materially
* Era normalization is required for historical comparison
* Playoffs preserve relative player quality while reducing absolute output
* Preseason data is significantly noisier than playoff data
* Peak dominance and career robustness are distinct analytical dimensions
* Longevity and adaptability materially affect career evaluation

---

## Technical Notes

* All computations executed in **MySQL**
* No external statistical tooling or machine learning
* Results derived from deterministic SQL views
* Emphasis on schema design, aggregation correctness, and validation

---

