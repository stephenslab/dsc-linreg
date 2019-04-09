# This R script implements the "ridge" module in the linreg DSC.
out  <- fit_ridge(X,y)
mu   <- out$mu
beta <- out$beta
