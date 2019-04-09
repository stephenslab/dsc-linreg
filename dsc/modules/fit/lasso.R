# This R script implements the "lasso" module in the linreg DSC.
out  <- fit_lasso(X,y)
mu   <- out$mu
beta <- out$beta
