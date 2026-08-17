dat <- read.csv("Documents/projects/MR-diabetes-stroke/data/harmonized_data_annotated.csv", row.names = 1)

# Create MR object
mr_obj <- mr_input(
  bx   = dat$beta.exposure,
  bxse = dat$se.exposure,
  by   = dat$beta.outcome,
  byse = dat$se.outcome
)

egger_res  <- mr_egger(mr_obj)
egger_res


egger_summary <- data.frame(
  method     = "MR-Egger",
  estimate   = egger_res@Estimate,
  se         = egger_res@StdError.Est,
  ci_lower   = egger_res@CILower.Est,
  ci_upper   = egger_res@CIUpper.Est,
  pvalue     = egger_res@Pvalue.Est,
  intercept  = egger_res@Intercept,
  int_se     = egger_res@StdError.Int,
  int_pvalue = egger_res@Pvalue.Int,
  Q          = egger_res@Heter.Stat[1],
  Q_pvalue   = egger_res@Heter.Stat[2],
  I2         = egger_res@I.sq
)

egger_summary

#save
write.csv(egger_summary, "Documents/projects/MR-diabetes-stroke/results/tables/egger_results.csv", row.names = FALSE)

# MR-Egger table
egger_table <- egger_summary %>%
  gt() %>%
  tab_header(title = "MR-Egger: Type 2 Diabetes → Ischemic Stroke") %>%
  fmt_number(columns = where(is.numeric), decimals = 3)

egger_table
gtsave(egger_table, "Documents/projects/MR-diabetes-stroke/results/figures/egger_table.png")
