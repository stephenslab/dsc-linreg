# TO DO: Explain here what this script does, and how to use it.
library(MASS)
source("toydata.R")
source("fit.R")

# Initialize the sequence of pseudorandom numbers.
set.seed(1)

# GENERATE DATA
# -------------
cat("Generating data set.\n")
dat <- simulate_toy_data(scenario = 1)

# RUN RIDGE REGRESSION
# --------------------
cat("Fitting ridge regression model to training data.\n")
ridge <- with(dat$train,fit_ridge(X,y))

# RUN LASSO METHOD
# ----------------
cat("Fitting Lasso model to training data.\n")
lasso <- with(dat$train,fit_lasso(X,y))

# RUN ELASTIC NET METHOD
# ----------------------
cat("Fitting Elastic Net model to training data.\n")
en <- with(dat$train,fit_elastic_net(X,y))

# PREDICT TEST OUTCOMES
# ---------------------
# TO DO.

# EVALUATE PREDICTIONS
# --------------------
# TO DO.
