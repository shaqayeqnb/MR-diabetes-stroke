# Scatter plot
png("Documents/projects/MR-diabetes-stroke/results/figures/scatter_plot.png",
    width = 800, height = 600)

plot(dat$beta.exposure, dat$beta.outcome,
     xlab = "SNP-diabetes association",
     ylab = "SNP-stroke association",
     main = "MR scatter plot: T2D and ischemic stroke",
     pch = 19)

abline(h = 0, v = 0, lty = 2, col = "grey")

abline(a = 0, b = ivw_result@Estimate, col = "blue", lwd = 2)

abline(a = egger_res@Intercept, b = egger_res@Estimate, col = "red", lwd = 2)

legend("topleft", legend = c("IVW", "MR-Egger"),
       col = c("blue", "red"), lwd = 2, bty = "n")

dev.off()


# Forest plot
dat$ratio_est <- dat$beta.outcome / dat$beta.exposure
dat$ratio_se  <- dat$se.outcome / abs(dat$beta.exposure)

sorted_data <- dat[order(dat$ratio_est), ]

png("Documents/projects/MR-diabetes-stroke/results/figures/forest_plot.png",
    width = 1000, height = 1500)

plot(sorted_data$ratio_est, 1:nrow(sorted_data),
     xlim = range(c(sorted_data$ratio_est - 1.96 * sorted_data$ratio_se,
                    sorted_data$ratio_est + 1.96 * sorted_data$ratio_se)),
     yaxt = "n", ylab = "", xlab = "Per-SNP causal estimate (ratio method)",
     main = "Forest plot: single-SNP MR estimates",
     pch = 19)

axis(2, at = 1:nrow(sorted_data), labels = sorted_data$SNP, las = 2, cex.axis = 0.7)

segments(sorted_data$ratio_est - 1.96 * sorted_data$ratio_se, 1:nrow(sorted_data),
         sorted_data$ratio_est + 1.96 * sorted_data$ratio_se, 1:nrow(sorted_data))

abline(v = 0, lty = 2, col = "grey")
abline(v = ivw_result@Estimate, col = "blue", lwd = 2)

legend("topright",
       legend = c("Null (0)", "IVW estimate"),
       col = c("grey", "blue"),
       lty = c(2, 1), lwd = c(1, 2),
       bty = "n")

dev.off()


# Funnel plot

png("Documents/projects/MR-diabetes-stroke/results/figures/funnel_plot.png",
    width = 800, height = 600)

plot(dat$ratio_est, 1 / dat$ratio_se,
     xlab = "Per-SNP causal estimate (ratio method)",
     ylab = "Precision (1/SE)",
     main = "Funnel plot: T2D and ischemic stroke",
     pch = 19)

abline(v = 0, lty = 2, col = "grey")
abline(v = ivw_result@Estimate, col = "blue", lwd = 2)

legend("topright",
       legend = c("Null (0)", "IVW estimate"),
       col = c("grey", "blue"),
       lty = c(2, 1), lwd = c(1, 2),
       bty = "n")

dev.off()
