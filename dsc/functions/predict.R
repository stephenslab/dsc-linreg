# This file contains functions to predict outcomes given various
# fitted models.

# Predict outcomes y from a simple linear regression, y = mu + X*beta,
# where X is an n x p matrix of observations, beta is a vector of
# regression coefficients of length p, and mu is the intercept.
predict_linear <- function (X, mu, beta)
  drop(mu + X %*% beta)

# Use the fitted susie model to predict n continuous outcomes given
# an n x p matrix of observations X. The return value is a vector of
# length n.
predict_susie <- function (fit, X)
  susieR::predict.susie(fit,X)

# Use the fitted varbvs model to predict n continuous outcomes given 
# an n x p matrix of observations X. The return value is a vector of 
# length n.
predict_varbvs <- function (fit, X)
  varbvs::predict.varbvs(fit,X)

# Use the fitted varbvsmix model to predict n continuous outcomes
# given an n x p matrix of observations X. The return value is a
# vector of length n.
predict_varbvsmix <- function (fit, X)
  varbvs::predict.varbvsmix(fit,X)
