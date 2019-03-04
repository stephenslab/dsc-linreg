# This file contains simple implementations of various methods for
# fitting linear regression models; methods include ridge regression,
# the Lasso, the Elastic Net, and varbvs (variational inference for
# Bayesian variable selection).

# Fit a ridge regression model to the data, and estimate the penalty
# strength (i.e., the normal prior on the regression coefficients)
# using cross-validation. Input X should be an n x p numeric matrix,
# and input y should be a numeric vector of length n. Input "nfolds"
# is the number of folds used in the cross-validation. The return
# value is a list with two elements: (1) the fitted glmnet object, (2)
# the output of cv.glmnet.
fit_ridge <- function (X, y, nfolds = 10) {
  out.cv <- glmnet::cv.glmnet(X,y,alpha = 0,nfolds = nfolds)
  fit    <- glmnet::glmnet(X,y,alpha = 0,standardize = FALSE)
  return(list(fit = fit,cv = out.cv))
}

# Fit a Lasso model to the data, and estimate the penalty strength
# (lambda) using cross-validation. Input X should be an n x p numeric
# matrix, and input y should be a numeric vector of length n. Input
# "nfolds" is the number of folds used in the cross-validation. The
# return value is a list with two elements: (1) the fitted glmnet
# object, (2) the output of cv.glmnet.
fit_lasso <- function (X, y, nfolds = 10) {
  out.cv <- glmnet::cv.glmnet(X,y,nfolds = nfolds)
  fit    <- glmnet::glmnet(X,y,standardize = FALSE)
  return(list(fit = fit,cv = out.cv))
}

# Fit an Elastic Net model to the data, and estimate the Elastic Net
# parameters (penalty strength, "lambda", and mixing parameter,
# "alpha"). Input X should be an n x p numeric matrix, and input y
# should be a numeric vector of length n. Input "nfolds" is the number
# of folds used in the cross-validation, and input "alpha" is the
# vector of candidate values of the Elastic Net mixing parameter. The
# return value is a list with three elements: (1) the fitted glmnet
# object, (2) the output of cv.glmnet, and (3) the setting of alpha
# minimizing the mean cross-validation error.
fit_elastic_net <- function (X, y, nfolds = 10, alpha = seq(0,1,0.05)) {
  n          <- nrow(X)
  foldid     <- rep_len(1:nfolds,n)
  out.cv     <- NULL
  cvm.min    <- Inf
  alpha.min  <- 1

  # Repeat for each candidate value of the alpha parameter, finding
  # the value of alpha that minimizes the mean cross-validation error.
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
  return(list(fit = fit,cv = out.cv,alpha = alpha.min))
}

# Compute a fully-factorized variational approximation for Bayesian
# variable selection in linear regression. Input X should be an n x p
# numeric matrix, and input y should be a numeric vector of length n.
fit_varbvs <- function (X, y) {
  logodds <- seq(-log10(ncol(X)),1,length.out = 40)
  return(varbvs::varbvs(X,NULL,y,logodds = logodds,verbose = FALSE))
}

# TO DO: Explain here what this function does, and how to use it.
fit_susie <- function (X, y)
  susieR::susie(X,y,L = ncol(X),max_iter = 1000,standardize = FALSE,
                estimate_prior_variance = TRUE)
