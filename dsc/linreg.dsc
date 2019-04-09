# A DSC for evaluating prediction accuracy of linear regression
# methods in different scenarios.

# simulate modules
# ================
# A "simulate" module generates a training and test data set used to
# evaluate the linear regression models. Each training and test data
# set should include an n x p matrix X and a vector y of length n,
# where n is the number of samples, and p is the number of candidate
# predictors. 

# Generate training and test data sets using one of the four scenarios
# described in Zou & Hastie (2005).
zh: zh.R
  seed:     R{1:20}
  scenario: 1, 2, 3, 4
  $X:       dat$train$X
  $y:       dat$train$y
  $Xtest:   dat$test$X
  $ytest:   dat$test$y
  $beta:    dat$b
  $se:      dat$se

# fit modules
# ===========
# A "fit" module fits a linear regression model to the provided
# training data, X and y.

# Fit a ridge regression model using glmnet. The penalty strength
# (i.e., the normal prior on the coefficients) is estimated using
# cross-validation.
ridge: ridge.R
  X:      $X
  y:      $y
  $model: out

# Fit a Lasso model using glmnet. The penalty strength ("lambda") is
# estimated via cross-validation.
lasso: lasso.R
  X:      $X
  y:      $y
  $model: out

# Fit an Elastic Net model using glmnet. The model parameters, lambda
# and alpha, are estimated using cross-validation.
elastic_net: elastic_net.R
  X:      $X
  y:      $y
  $model: out

# Fit a "sum of single effects" (SuSiE) regression model.
susie: susie.R
  X:      $X
  y:      $y
  $model: out

# Compute a fully-factorized variational approximation for Bayesian
# variable selection in linear regression (varbvs).
varbvs: varbvs.R
  X:      $X
  y:      $y
  $model: out

# This is a variant on the varbvs method in which the "spike-and-slab"
# prior on the regression coefficients is replaced with a
# mixture-of-normals prior.
varbvsmix: varbvsmix.R
  X:      $X
  y:      $y
  $model: out

# predict modules
# ===============
# "predict" module takes as input a fitted model and an n x p matrix
# of observations, X, and returns a vector of length n containing the
# outcomes predicted by the fitted model.

# Predict outcomes using a fitted ridge regression model.
predict_ridge: predict_ridge.R
  X:     $Xtest
  model: $model
  $yest: y

# Predict outcomes using a fitted Lasso model.
predict_lasso: predict_lasso.R
  X:     $Xtest
  model: $model
  $yest: y

# Predict outcomes using a fitted Elastic Net model.
predict_elastic_net: predict_elastic_net.R
  X:     $Xtest
  model: $model
  $yest: y

# Predict outcomes using a fitted SuSiE model.
predict_susie: predict_susie.R
  X:     $Xtest
  model: $model
  $yest: y

# Predict outcomes using a fitted varbvs model.
predict_varbvs: predict_varbvs.R
  X:     $Xtest
  model: $model
  $yest: y

# Predict outcomes using a fitted varbvsmix model.
predict_varbvsmix: predict_varbvsmix.R
  X:     $Xtest
  model: $model
  $yest: y

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
  R_libs:    MASS, glmnet, susieR, varbvs >= 2.6-1
  lib_path:  functions
  exec_path: modules/simulate,
             modules/fit,
             modules/predict,
             modules/score
  define:
    simulate: toydata
    fit:      ridge, lasso, elastic_net, susie, varbvs, varbvsmix
    predict:  predict_ridge, predict_lasso, predict_elastic_net,
              predict_susie, predict_varbvs, predict_varbvsmix
    analyze:  ridge       * predict_ridge,
              lasso       * predict_lasso,
              elastic_net * predict_elastic_net,
              susie       * predict_susie,
              varbvs      * predict_varbvs,
              varbvsmix   * predict_varbvsmix
    score:    mse, mae
  run: simulate * analyze * score
