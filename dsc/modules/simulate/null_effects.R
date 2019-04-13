# This R script implements the "null_effects" module in the linreg DSC.
se    <- 3
b     <- rep(0,8)
X     <- simulate_predictors_decaying_corr(40,8,0.5)
Xtest <- simulate_predictors_decaying_corr(200,8,0.5)
y     <- simulate_outcomes(X,b,se)
ytest <- simulate_outcomes(Xtest,b,se)
