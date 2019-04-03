# This R script implements the "susie_ests0" module in the linreg DSC.
source("functions/fit.R")
out <- fit_susie(X,y,estimate_prior_variance = TRUE)
