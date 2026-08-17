dat <- read_csv("Documents/projects/MR-diabetes-stroke/data/raw/harmonised_data_full.csv")
View(dat)

# Explore data set
str(dat)
head(dat)
cat("Dimension of dataset:", dim(dat), "\n")


summary(dat$beta.exposure)
summary(dat$beta.outcome)


# instrument strength (F-static per SNP)
dat$f_stat <- (dat$beta.exposure / dat$se.exposure)^2
summary(dat$f_stat)
cat("Number of SNPs:", nrow(dat), "\n")
cat("SNPs with F < 10:", sum(dat$f_stat < 10), "\n")

# Save the annotated file
write.csv(dat, "Documents/projects/MR-diabetes-stroke/data/harmonized_data_annotated.csv", row.names = TRUE)

