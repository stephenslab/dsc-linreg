# This short script demonstrates the model fitting methods on a small
# data set.
source("simulate.R")
source("fit.R")
source("predict.R")
source("score.R")

# Initialize the sequence of pseudorandom numbers.
set.seed(1)

# GENERATE DATA
# -------------
cat("Generating data set.\n")
dat <- simulate_toy_data(scenario = 1)

# FITMODELS
# ----------
cat("Fitting models:\n")
cat(" - ridge\n")
ridge <- with(dat$train,fit_ridge(X,y))
cat(" - lasso\n")
lasso <- with(dat$train,fit_lasso(X,y))
cat(" - elastic net\n")
en <- with(dat$train,fit_elastic_net(X,y))
cat(" - varbvs\n")
varbvs <- with(dat$train,fit_varbvs(X,y))
cat(" - susie\n")
susie <- with(dat$train,fit_susie(X,y))

# PREDICT TEST OUTCOMES
# ---------------------
cat("Predicting outcomes in test examples using fitted models.\n")
y.ridge  <- predict_ridge(ridge,dat$test$X)
y.lasso  <- predict_lasso(lasso,dat$test$X)
y.en     <- predict_elastic_net(en,dat$test$X)
y.varbvs <- predict_varbvs(varbvs,dat$test$X)
y.susie  <- predict_susie(susie,dat$test$X)

# EVALUATE PREDICTIONS
# --------------------
cat("Mean squared error in test examples:\n")
cat(sprintf(" - ridge:       %0.4f\n",mse(dat$test$y,y.ridge)))
cat(sprintf(" - lasso:       %0.4f\n",mse(dat$test$y,y.lasso)))
cat(sprintf(" - elastic net: %0.4f\n",mse(dat$test$y,y.en)))
cat(sprintf(" - varbvs:      %0.4f\n",mse(dat$test$y,y.varbvs)))
cat(sprintf(" - susie:       %0.4f\n",mse(dat$test$y,y.susie)))
