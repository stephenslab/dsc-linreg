# TO DO: Briefly explain here what this script is for.
library(dscrutils)

# Extract the results.
out <- dscquery("linreg",
                c("simulate.seed","simulate.scenario","fit","mse"))
out <- transform(out,
                 fit               = factor(fit),
                 predict           = factor(predict),
                 simulate          = factor(simulate),
                 simulate.scenario = factor(simulate.scenario))
summary(out)
