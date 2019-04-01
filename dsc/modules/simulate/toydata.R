# This R script implements the "toydata" module in the linreg DSC.
source("functions/simulate.R")
set.seed(seed)
dat <- simulate_toy_data(scenario)
