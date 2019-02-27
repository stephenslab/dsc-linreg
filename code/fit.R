# TO DO: Summarize the contents of this file.

# NOTES:
#   - X should be an n x p numeric matrix.
#   - y should be a numeric vector of length n.
#   - nfolds is a parameter to cv.glmnet.
#   - Returns: (1) the fitted glmnet object, (2) the output of cv.glmnet.
fit_lasso <- function (X, y, nfolds = 10) {
  out.cv <- glmnet::cv.glmnet(X,y,nfolds = nfolds)
  fit    <- glmnet::glmnet(X,y,standardize = FALSE)
  return(list(fit = fit,cv = out.cv))
}

# TO DO: Explain here what this function does, and how to use it.
fit_elastic_net <- function (X, y, nfolds = 10, alpha = seq(0,1,0.1)) {

}
