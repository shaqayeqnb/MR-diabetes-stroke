install.packages("MendelianRandomization")
install.packages("gt")
install.packages("dplyr")
install.packages("remotes")
install.packages("usethis")
remotes::install_github("MRCIEU/TwoSampleMR")
remotes::install_github("MRCIEU/ieugwasr")

library(TwoSampleMR)
library(ieugwasr)
library(readr)
library(MendelianRandomization)
library(gt)
library(dplyr)

ieugwasr::get_opengwas_jwt()

usethis::edit_r_environ()
ieugwasr::user()

