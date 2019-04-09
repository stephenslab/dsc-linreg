# This short script demonstrates the model fitting methods on a small
# data set.
source("functions/simulate.R")
source("functions/fit.R")
source("functions/predict.R")
source("functions/score.R")

# Initialize the sequence of pseudorandom numbers.
set.seed(1)

# GENERATE DATA
# -------------
cat("Generating data set.\n")
dat <- simulate_zh_data(scenario = 1)

# FITMODELS
# ----------
cat("Fitting models:\n")
cat(" - ridge\n")
ridge <- with(dat$train,fit_ridge(X,y))
cat(" - lasso\n")
lasso <- with(dat$train,fit_lasso(X,y))
cat(" - elastic net\n")
en <- with(dat$train,fit_elastic_net(X,y))
cat(" - susie\n")
susie <- with(dat$train,fit_susie(X,y))
cat(" - varbvs\n")
varbvs <- with(dat$train,fit_varbvs(X,y))
cat(" - varbvsmix\n")
varbvsmix <- with(dat$train,fit_varbvsmix(X,y))

# PREDICT TEST OUTCOMES
# ---------------------
cat("Predicting outcomes in test examples using fitted models.\n")
y.ridge     <- with(ridge,predict_linear(dat$test$X,mu,beta))
y.lasso     <- with(lasso,predict_linear(dat$test$X,mu,beta))
y.en        <- with(en,predict_linear(dat$test$X,mu,beta))
y.susie     <- with(susie,predict_linear(dat$test$X,mu,beta))
y.varbvs    <- with(varbvs,predict_linear(dat$test$X,mu,beta))
y.varbvsmix <- with(varbvsmix,predict_linear(dat$test$X,mu,beta))

# EVALUATE PREDICTIONS
# --------------------
cat("Mean squared error in test examples:\n")
cat(sprintf(" - ridge:       %0.4f\n",mse(dat$test$y,y.ridge)))
cat(sprintf(" - lasso:       %0.4f\n",mse(dat$test$y,y.lasso)))
cat(sprintf(" - elastic net: %0.4f\n",mse(dat$test$y,y.en)))
cat(sprintf(" - susie:       %0.4f\n",mse(dat$test$y,y.susie)))
cat(sprintf(" - varbvs:      %0.4f\n",mse(dat$test$y,y.varbvs)))
cat(sprintf(" - varbvsmix:   %0.4f\n",mse(dat$test$y,y.varbvsmix)))
