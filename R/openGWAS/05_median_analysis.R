dat <- read.csv("Documents/projects/MR-diabetes-stroke/data/harmonized_data_annotated.csv", row.names = 1)

# Create MR object
mr_obj <- mr_input(
  bx   = dat$beta.exposure,
  bxse = dat$se.exposure,
  by   = dat$beta.outcome,
  byse = dat$se.outcome
)

median_result <- mr_median(mr_obj, weighting = "weighted")
median_result

slotNames(median_result)


# save summary
median_summary <- data.frame(
  method   = "Weighted Median",
  estimate = median_result@Estimate,
  se       = median_result@StdError,
  ci_lower = median_result@CILower,
  ci_upper = median_result@CIUpper,
  pvalue   = median_result@Pvalue
)

median_summary

#save
write.csv(median_summary, "Documents/projects/MR-diabetes-stroke/results/tables/median_results.csv", row.names = FALSE)

# MR_median table
median_table <- median_summary %>%
  gt() %>%
  tab_header(title = "Weighted Median: Type 2 Diabetes → Ischemic Stroke") %>%
  fmt_number(columns = where(is.numeric), decimals = 3)

median_table
gtsave(median_table, "Documents/projects/MR-diabetes-stroke/results/figures/median_table.png")
