# This R script implements the "one_effect" module in the linreg DSC.
set.seed(seed)
se         <- 3
b          <- c(3,0,0,0,0,0,0,0)
dat        <- list()
dat$Xtrain <- simulate_predictors_decaying_corr(40,8,0.5)
dat$Xtest  <- simulate_predictors_decaying_corr(200,8,0.5)
dat$ytrain <- simulate_outcomes(Xtrain,b,se)
dat$ytest  <- simulate_outcomes(Xtest,b,se)
