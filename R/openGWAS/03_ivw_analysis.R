dat <- read.csv("Documents/projects/MR-diabetes-stroke/data/harmonized_data_annotated.csv", row.names = 1)

names(dat)

# Create MR object
mr_obj <- mr_input(
  bx   = dat$beta.exposure,
  bxse = dat$se.exposure,
  by   = dat$beta.outcome,
  byse = dat$se.outcome
)

ivw_result <- mr_ivw(mr_obj)
ivw_result


# save results
ivw_summary <- data.frame(
  method   = "IVW (random)",
  estimate = ivw_result@Estimate,
  se       = ivw_result@StdError,
  ci_lower = ivw_result@CILower,
  ci_upper = ivw_result@CIUpper,
  pvalue   = ivw_result@Pvalue,
  Q        = ivw_result@Heter.Stat[1],
  Q_df     = ivw_result$SNPs - 1,
  Q_pvalue = ivw_result@Heter.Stat[2],
  I_squared= ((ivw_result@Heter.Stat[1] - (ivw_result$SNPs - 1)) / ivw_result@Heter.Stat[1]) * 100,
  F        = ivw_result$Fstat
)

ivw_summary

# save
write.csv(ivw_summary, "Documents/projects/MR-diabetes-stroke/results/tables/ivw_results.csv", row.names = FALSE)

# IVW table
ivw_table <- ivw_summary %>%
  gt() %>%
  tab_header(title = "IVW: Type 2 Diabetes → Ischemic Stroke") %>%
  fmt_number(columns = where(is.numeric), decimals = 3)

ivw_table

gtsave(ivw_table, "Documents/projects/MR-diabetes-stroke/results/figures/ivw_table.png")
