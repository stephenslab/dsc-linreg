# A DSC for evaluating prediction accuracy of linear regression
# methods in different scenarios.

# simulate modules
# ================
# A "simulate" module generates a training and test data set used to
# evaluate the linear regression models. Each training and test data
# set should include an n x p matrix X and a vector y of length n,
# where n is the number of samples, and p is the number of candidate
# predictors. All simulate modules should inherit the inputs outputs,
# and module parameters of the "generic" fit module.
simulate_generic: R(NULL)
  seed:   R{1:20}
  $X:     X
  $y:     y
  $Xtest: Xtest
  $ytest: ytest
  $beta:  b

# Simulate data in the same way as Example 1 of Zou & Hastie (2005),
# except that all the regression coefficients are zero.
null_effects(simulate_generic): null_effects.R
  $se: se

# Simulate data in the same way as Example 1 of Zou & Hastie (2005),
# except that all the regression coefficients except one are zero.
# The inputs, outputs and module parameters are the same as the "null"
# simulate module.
one_effect(simulate_generic): one_effect.R
  $se: se
  
# Generate training and test data sets using one of the four scenarios
# described in Zou & Hastie (2005). This module inherits the inputs,
# outputs and module parameters from the "null" simulate module.
zh(simulate_generic): zh.R
  scenario: 1, 2, 3, 4
  $X:     out$train$X
  $y:     out$train$y
  $Xtest: out$test$X
  $ytest: out$test$y
  $beta:  out$b

# fit modules
# ===========
# A "fit" module fits a linear regression model to the provided
# training data, X and y. All fit modules should inherit the inputs
# and outputs of the "generic" fit module.
fit_generic: R(NULL)
  X:          $X
  y:          $y
  $intercept: mu
  $beta_est:  beta

# Fit a ridge regression model using glmnet. The penalty strength
# (i.e., the normal prior on the coefficients) is estimated using
# cross-validation.
ridge(fit_generic): ridge.R
  $model:     out
  $intercept: out$mu
  $beta_est:  out$beta
  
# Fit a Lasso model using glmnet. The penalty strength ("lambda") is
# estimated via cross-validation.
lasso(fit_generic): lasso.R
  $model:     out
  $intercept: out$mu
  $beta_est:  out$beta

# Fit an Elastic Net model using glmnet. The model parameters, lambda
# and alpha, are estimated using cross-validation.
elastic_net(fit_generic): elastic_net.R
  $model:     out
  $intercept: out$mu
  $beta_est:  out$beta

# Fit a "sum of single effects" (SuSiE) regression model.
susie(fit_generic): susie.R
  $model:     out$fit
  $intercept: out$mu
  $beta_est:  out$beta

# Compute a fully-factorized variational approximation for Bayesian
# variable selection in linear regression (varbvs).
varbvs(fit_generic): varbvs.R
  $model:     out$fit
  $intercept: out$mu
  $beta_est:  out$beta

# This is a variant on the varbvs method in which the "spike-and-slab"
# prior on the regression coefficients is replaced with a
# mixture-of-normals prior.
varbvsmix(fit_generic): varbvsmix.R
  $model:     out$fit
  $intercept: out$mu
  $beta_est:  out$beta

# predict modules
# ===============
# A "predict" module takes as input a fitted model (or the parameters
# of this fitted model) and an n x p matrix of observations, X, and
# returns a vector of length n containing the outcomes predicted by
# the fitted model.

# Predict outcomes from a fitted linear regression model.
predict_linear: predict_linear.R
  X:         $Xtest
  intercept: $intercept
  beta:      $beta_est
  $yest:     y

# score modules
# =============
# A "score" module takes as input a vector of predicted outcomes and a
# vector of true outcomes, and outputs a summary statistic that can be
# used to evaluate accuracy of the predictions.

# Compute the mean squared error summarizing the differences between
# the predicted outcomes and the true outcomes.
mse: mse.R
  y:    $ytest
  yest: $yest
  $err: err

# Compute the mean absolute error summarizing the differences between
# the predicted outcomes and the true outcomes.
mae: mae.R
  y:    $ytest
  yest: $yest
  $err: err
  
DSC:
  R_libs:    MASS, glmnet, susieR, varbvs >= 2.6-3
  lib_path:  functions
  exec_path: modules/simulate,
             modules/fit,
             modules/predict,
             modules/score
  define:
    simulate: null_effects, one_effect, zh
    fit:      ridge, lasso, elastic_net, susie, varbvs, varbvsmix
    predict:  predict_linear
    score:    mse, mae
  run: simulate * fit * predict * score
