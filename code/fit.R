# TO DO: Summarize the contents of this file.

# NOTES:
#   - X should be an n x p numeric matrix.
#   - y should be a numeric vector of length n.
#   - nfolds is a parameter to cv.glmnet.
#   - Returns the fitted glmnet object.
fit_lasso <- function (X, y, nfolds = 10) {
  out.cv <- cv.glmnet(X,y,nfolds = nfolds)
  fit    <- glmnet(X,y,standardize = FALSE)
}

# TO DO: Explain here what this function does, and how to use it.
fit_elastic_net <- function (X, y, nfolds = 10, alpha = seq(0,1,0.1)) {

}
