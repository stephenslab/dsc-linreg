# This file contains simple implementations of various methods for
# fitting linear regression models; methods include ridge regression,
# the Lasso, the Elastic Net, and varbvs (variational inference for
# Bayesian variable selection).

# Fit a ridge regression model to the data, and estimate the penalty
# strength (i.e., the normal prior on the regression coefficients)
# using cross-validation. Input X should be an n x p numeric matrix,
# and input y should be a numeric vector of length n. Input "nfolds"
# is the number of folds used in the cross-validation. The return
# value is a list with four elements: (1) the fitted glmnet object,
# (2) the output of cv.glmnet, (3) the intercept at the penalty
# strength ("lambda") chosen by cross-validation, and (4) the
# regression coefficients at this value of lambda.
fit_ridge <- function (X, y, nfolds = 10)
  fit_lasso(X,y,nfolds,0)

# Fit a Lasso model to the data, and estimate the penalty strength
# (lambda) using cross-validation. Input X should be an n x p numeric
# matrix, and input y should be a numeric vector of length n. Input
# "nfolds" is the number of folds used in the cross-validation. four
# elements: (1) the fitted glmnet object, (2) the output of cv.glmnet,
# (3) the intercept at the penalty strength ("lambda") chosen by
# cross-validation, and (4) the regression coefficients at this value
# of lambda.
fit_lasso <- function (X, y, nfolds = 10, alpha = 1) {
  out.cv <- glmnet::cv.glmnet(X,y,alpha = alpha,nfolds = nfolds)
  fit    <- glmnet::glmnet(X,y,alpha = alpha,standardize = FALSE)
  b      <- as.vector(coef(fit,s = out.cv$lambda.min))
  return(list(fit = fit,cv = out.cv,mu = b[1],beta = b[-1]))
}

# Fit an Elastic Net model to the data, and estimate the Elastic Net
# parameters (penalty strength, "lambda", and mixing parameter,
# "alpha") using cross-validation. Input X should be an n x p numeric
# matrix, and input y should be a numeric vector of length n. Input
# "nfolds" is the number of folds used in the cross-validation, and
# input "alpha" is the vector of candidate values of the Elastic Net
# mixing parameter. The return value is a list with five elements: (1)
# the fitted glmnet object, (2) the output of cv.glmnet, (3) the
# setting of alpha minimizing the mean cross-validation error, (4) the
# intercept at the penalty strength ("lambda") chosen by
# cross-validation, and (3) the regression coefficients at this value
# of lambda.
fit_elastic_net <- function (X, y, nfolds = 10, alpha = seq(0,1,0.05)) {
  n          <- nrow(X)
  foldid     <- rep_len(1:nfolds,n)
  out.cv     <- NULL
  cvm.min    <- Inf
  alpha.min  <- 1

  # Identify the setting of alpha that minimizes the mean
  # cross-validation error.
  for (i in alpha) {
    out <- glmnet::cv.glmnet(X,y,nfolds = nfolds,foldid = foldid,alpha = i)
    if (min(out$cvm) < cvm.min) {
      cvm.min    <- min(out$cvm)
      alpha.min  <- i
      out.cv     <- out
    }
  }

  # Fit the Elastic Net model using the chosen value of alpha.
  fit <- glmnet::glmnet(X,y,standardize = FALSE,alpha = alpha.min)
  b   <- as.vector(coef(fit,s = out.cv$lambda.min))
  return(list(fit = fit,cv = out.cv,alpha = alpha.min,mu = b[1],
              beta = b[-1]))
}

# Fit a "sum of single effects" (SuSiE) regression model to the
# provided data. The data are specified by inputs X and y; X should be
# an n x p numeric matrix, and y should be a numeric vector of length
# n. Note that we found that the prediction performance was more
# robust when setting estimate_prior_variance = FALSE.
fit_susie <- function (X, y, scaled_prior_variance = 0.2) {
  fit <- susieR::susie(X,y,L = ncol(X),max_iter = 1000,standardize = FALSE,
                       scaled_prior_variance = scaled_prior_variance,
                       estimate_prior_variance = FALSE)
  b   <- as.vector(coef(fit))
  return(list(fit = fit,mu = b[1],beta = b[-1]))
}

# Compute a fully-factorized variational approximation for Bayesian
# variable selection in linear regression. Input X should be an n x p
# numeric matrix, and input y should be a numeric vector of length n.
# 
# In this implementation, candidate values of the prior inclusion
# probability (determined by "logodds") are provided, and the results
# are averaged over the settings, whereas the hyperparameters are
# automatically fitted separately for each logodds setting.
fit_varbvs <- function (X, y) {
  logodds <- seq(-log10(ncol(X)),1,length.out = 40)
  fit     <- varbvs::varbvs(X,NULL,y,logodds = logodds,verbose = FALSE)
  b       <- as.vector(coef(fit)[,"averaged"])
  return(list(fit = fit,mu = b[1],beta = b[-1]))
}

# Compute a fully-factorized variational approximation for the
# Bayesian variable selection model with mixture-of-normals priors on
# the regression coefficients. The variances of the mixture components
# are chosen automatically based on the data. Input argument k
# controls the number of mixture components.
fit_varbvsmix <- function (X, y, k = 20) {
  fit <- varbvs::varbvsmix(X,NULL,y,k,verbose = FALSE)
  b   <- as.vector(coef(fit))
  return(list(fit = fit,mu = b[1],beta = b[-1]))
}
