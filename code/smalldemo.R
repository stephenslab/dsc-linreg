# TO DO: Explain here what this script does, and how to use it.
library(MASS)
source("toydata.R")
source("fit.R")
source("predict.R")
source("score.R")

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
cat("Predicting outcomes in test examples using fitted models.\n")
y.ridge <- with(dat$test,predict_ridge(ridge,X))
y.lasso <- with(dat$test,predict_lasso(lasso,X))
y.en    <- with(dat$test,predict_elastic_net(en,X))

# EVALUATE PREDICTIONS
# --------------------
cat("Mean squared error in test examples:\n")
cat(sprintf(" - ridge:       %0.4f\n",mse(dat$test$y,y.ridge)))
cat(sprintf(" - lasso:       %0.4f\n",mse(dat$test$y,y.lasso)))
cat(sprintf(" - elastic net: %0.4f\n",mse(dat$test$y,y.en)))
