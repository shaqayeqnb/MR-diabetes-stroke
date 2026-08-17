# Mendelian Randomization: Type 2 Diabetes and Ischemic Stroke

## Research question

Does genetic liability to Type 2 diabetes have a causal effect on risk of
ischemic stroke?

Observational associations between diabetes and stroke are heavily confounded
by shared risk factors (obesity, hypertension, dyslipidaemia, smoking,
physical inactivity). This project uses two-sample Mendelian randomization
(MR) to assess whether this association reflects a causal relationship,
using genetic variants associated with T2D as instrumental variables.

## Data

`data/raw/diabetes_data.csv` contains harmonised SNP-level summary
statistics:

| column | meaning |
|---|---|
| `SNP` | rsID of the genetic variant |
| `beta.exposure` | per-allele association with Type 2 diabetes (log-odds) |
| `se.exposure` | standard error of the exposure association |
| `beta.outcome` | per-allele association with ischemic stroke (log-odds) |
| `se.outcome` | standard error of the outcome association |

Data were pre-harmonised (aligned to the same effect allele, same strand)
before analysis.

## Methods

1. **Instrument validation** — F-statistics per SNP to check for weak
   instrument bias (`R/01_load_and_validate.R`).
2. **Primary analysis** — inverse-variance weighted (IVW) MR, comparing
   fixed-effect vs random-effects models (`R/02_ivw_analysis.R`).
3. **Pleiotropy-robust sensitivity analyses** — MR-Egger (intercept test for
   directional pleiotropy) and weighted median (`R/03_egger_median.R`).
4. **Leave-one-out analysis** — re-estimating IVW with each SNP excluded in
   turn, to check for disproportionately influential variants
   (`R/04_sensitivity.R`).
5. **Visualisation** — scatter, forest, and funnel plots
   (`R/05_plots.R`).

## Reproducing this analysis

```r
# from the repo root, with this as your working directory
source("R/00_setup.R")
source("R/01_load_and_validate.R")
source("R/02_ivw_analysis.R")
source("R/03_egger_median.R")
source("R/04_sensitivity.R")
source("R/05_plots.R")
```

## Results

See `results/tables/` for numeric output and `results/figures/` for plots.
A summary write-up of findings and interpretation is in
`docs/interpretation.md`.

## Limitations

- Sample size (number of instruments) constrains power to detect small
  effects and to distinguish between competing MR methods.
- Binary exposure (diabetes) MR estimates should be interpreted as the
  effect of genetic *liability* to diabetes, not of diabetes onset itself.
- Possible sample overlap between exposure and outcome GWAS was not
  assessed here; overlap can bias estimates toward the observational
  association.
