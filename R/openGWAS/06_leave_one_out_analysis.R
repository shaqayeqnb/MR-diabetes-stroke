dat <- read.csv("Documents/projects/MR-diabetes-stroke/data/harmonized_data_annotated.csv", row.names = 1)

n_snps <- nrow(dat)

results <- data.frame(
  snp_removed = character(n_snps),
  estimate    = numeric(n_snps),
  se          = numeric(n_snps),
  ci_lower    = numeric(n_snps),
  ci_upper    = numeric(n_snps),
  pvalue      = numeric(n_snps)
)

for (i in 1:n_snps) {
  dat_i <- dat[-i, ]   # remove SNP i
  
  obj_i <- mr_input(
    bx   = dat_i$beta.exposure,
    bxse = dat_i$se.exposure,
    by   = dat_i$beta.outcome,
    byse = dat_i$se.outcome
  )
  
  res_i <- mr_ivw(obj_i)
  
  results$snp_removed[i] <- dat$SNP[i]
  results$estimate[i]    <- res_i@Estimate
  results$se[i]          <- res_i@StdError
  results$ci_lower[i]    <- res_i@CILower
  results$ci_upper[i]    <- res_i@CIUpper
  results$pvalue.        <- res_i@Pvalue
}

results

results_sorted <- results[order(results$estimate), ]

head(results_sorted, 3)   # SNPs pulling estimate lowest
tail(results_sorted, 3)   # SNPs pulling estimate highest

# save
write.csv(results, "Documents/projects/MR-diabetes-stroke/results/tables/leave_one_out.csv", row.names = FALSE)
