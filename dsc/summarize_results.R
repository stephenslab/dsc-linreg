# TO DO: Briefly explain here what this script is for.
library(dscrutils)
library(ggplot2)
library(cowplot)

# Extract the results.
out <- dscquery("linreg",targets = c("simulate.scenario","fit","mse.err"))
out <- transform(out,
                 simulate.scenario = factor(simulate.scenario,1:4),
                 fit               = factor(fit))
