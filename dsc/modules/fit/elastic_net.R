# This R script implements the "elastic_net" module in the linreg DSC.
out  <- fit_elastic_net(X,y)
mu   <- out$mu
beta <- out$beta
