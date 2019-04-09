# This R script implements the "one_effect" module in the linreg DSC.
set.seed(seed)
se     <- 3
b      <- c(3,0,0,0,0,0,0,0)
Xtrain <- simulate_predictors_decaying_corr(40,8,0.5)
Xtest  <- simulate_predictors_decaying_corr(200,8,0.5)
ytrain <- simulate_outcomes(Xtrain,b,se)
ytest  <- simulate_outcomes(Xtest,b,se)
dat <- list(train = list(X = Xtrain,y = ytrain),
            test  = list(X = Xtest,y = ytest))
