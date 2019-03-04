# TO DO: Summarize the contents of this file.

# TO DO: Describe here what this function does, and how to use it.
predict_ridge <- function (fit, X) {
  predict.glmnet(fit,X,lambda = )
}

# TO DO: Describe here what this function does, and how to use it.
predict_lasso <- function (lasso, X) {
  if (!inherits(lasso$fit,"glmnet"))
    stop("Input argument \"lasso$fit\" should be a \"glmnet\" object")
  fit    <- lasso$fit
  lambda <- lasso$cv$lambda.min
  return(drop(predict(fit,X,lambda)))
}
