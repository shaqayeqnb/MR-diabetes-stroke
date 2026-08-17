ao <- available_outcomes()

# Type 2 Diabetes
diabetes_studies <- ao[grepl("diabetes", ao$trait, ignore.case = TRUE), ]
diabetes_studies[, c("id", "trait", "sample_size", "population")]

diabetes_europe <- diabetes_studies[diabetes_studies$population == "European", ]
diabetes_europe_sorted <- diabetes_europe[order(-diabetes_europe$nsnp, -diabetes_europe$sample_size), ]

diabetes_dat <- extract_instruments(outcomes = "ebi-a-GCST90018926")
exposure_dat <- diabetes_dat
dim(diabetes_dat)

# ischemic stroke
stroke_studies <- ao[grepl("ischemic stroke", ao$trait, ignore.case = TRUE), ]
stroke_europe <- stroke_studies[stroke_studies$population == "European", ]
stroke_europe_sorted <- stroke_europe[order(-stroke_europe$nsnp, -stroke_europe$sample_size), ]

outcome_dat <- extract_outcome_data(
  snps = exposure_dat$SNP,
  outcomes = "ebi-a-GCST90018864"
)
dim(stroke_dat)

length(unique(exposure_dat$SNP))  # how many SNPs you started with
length(unique(outcome_dat$SNP))    # how many actually came back

dim(exposure_dat)
dim(outcome_dat)

outcome_dat$SNP[duplicated(outcome_dat$SNP)]

#final dataset
dat <- harmonise_data(exposure_dat, outcome_dat, action = 2)

dim(dat)
table(dat$mr_keep)

dat <- dat[dat$mr_keep == TRUE, ]
dim(dat)

names(dat)

#save data
write.csv(dat, "Documents/projects/MR-diabetes-stroke/data/raw/harmonised_data_full.csv", row.names = FALSE)
