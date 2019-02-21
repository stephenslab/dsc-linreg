# TO DO: Explain here what this script does, and how to use it.
library(MASS)
source("toydata.R")

# SCRIPT PARAMETERS
# -----------------
scenarios <- c("zh1","zh2","zh3","zh4")
methods   <- c("lasso")

# Initialize the sequence of pseudorandom numbers.
set.seed(1)

# Repeat for each simulation scenario.
for (scenario in scenarios) {

  # GENERATE DATA
  # -------------
  cat(sprintf("Generating data for \"%s\" scenario.\n",scenario))
  # TO DO.

  # Repeat for each method.
  for (method in methods) {

    # FIT MODEL
    # ---------
    # TO DO.

    # PREDICT TEST OUTCOMES
    # ---------------------
    # TO DO.

    # EVALUATE PREDICTIONS
    # --------------------
    # TO DO.
  }
}
