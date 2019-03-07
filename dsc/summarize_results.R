# TO DO: Briefly explain here what this script is for.
library(dscrutils)

# Extract the results.
out <- dscquery("linreg",c("fit","mse"))
out <- transform(out,fit = factor(fit))
summary(out)
