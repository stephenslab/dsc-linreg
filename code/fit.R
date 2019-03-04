# TO DO: Summarize the contents of this file.

# Fit a Lasso model to the data, and estimate the penalty strength
# (lambda) using cross-validation. Input X should be an n x p numeric
# matrix, and input y should be a numeric vector of length n. Input
# "nfolds" the number of folds used in the cross-validation. The
# return value is a list with two elements: (1) the fitted glmnet
# object, (2) the output of cv.glmnet.
fit_lasso <- function (X, y, nfolds = 10) {
  out.cv <- glmnet::cv.glmnet(X,y,nfolds = nfolds)
  fit    <- glmnet::glmnet(X,y,standardize = FALSE)
  return(list(fit = fit,cv = out.cv))
}

# TO DO: Explain here what this function does, and how to use it.
fit_elastic_net <- function (X, y, nfolds = 10, alpha = seq(0,1,0.05)) {
  rows       <- sample(nrow(X))
  out.cv     <- NULL
  lambda.min <- Inf
  alpha.min  <- 1
  for (i in alpha) {
    out <- glmnet::cv.glmnet(X,y,nfolds = nfolds,foldid = rows,alpha = i)
    if (out$lambda.min < lambda.min) {
      lambda.min <- out$lambda.min
      alpha.min  <- i
      out.cv     <- out
    }
  }
  fit <- glmnet::glmnet(X,y,standardize = FALSE,)
  return(list(fit = fit,cv = out.cv))
}
