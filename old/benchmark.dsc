#!/usr/bin/env dsc

# pipeline variables
# ==================
# $Y an n vector of outcomes (training data).
# $X an n by p matrix of covariates (training data).
# $Ytest an n vector of outcomes in test data.
# $Xtest an n by p matrix of covariates in test data.
# $beta_est an n vector of estimated values beta (learned
#   from training data).
# $error a scalar measure of accuracy.

# module groups
# =============
# simulate: -> $X, $Y, $Xtest, $Ytest
# analyze: $Y, $X -> $beta_est
# score: $beta_est, $Xtest, $Ytest -> $error

# simulate modules

en_sim: simulate.R + R(d = en_sim(scenario))
  scenario: "eg1", "eg2", "eg3", "eg4", "eg1b"
  $Y: d$Y
  $X: d$X
  $Ytest: d$Ytest
  $Xtest: d$Xtest
  $beta_true: d$beta

sparse: simulate.R + R(d = simple_sim_regression(n,p,pve,pi0))
  scenario: "sparse"
  n: 100
  p: 100
  pve: 0.5
  pi0: 0.9
  $Y: d$Y
  $X: d$X
  $Ytest: d$Ytest
  $Xtest: d$Xtest
  $beta_true: d$beta

dense(sparse):
  scenario: "dense"
  pi0: 0


# analyze modules

glmnet: glmnet_fit.R
  X: $X
  Y: $Y
  $beta_est: bhat

lasso(glmnet):
  alpha: 1

ridge(glmnet):
  alpha: 0

en(glmnet):
  alpha: 0.5

varbvs: R(p   = ncol(X);
          fit = varbvs::varbvs(X,Z = NULL,y = Y,
                               logodds = 10^seq(-p,0,length.out = 20)))
  X: $X
  Y: $Y
  $beta_est: fit$beta

varbvsmix: R(fit  = varbvs::varbvsmix(X,Z = NULL,y = Y,
                                      sa = c(0,0.05,0.1,0.2,0.4));
             bhat = with(fit,rowSums(alpha * mu)))
  X: $X
  Y: $Y
  $beta_est: bhat

# fits susie without intercept and returns coefficients without intercept
susie: R(fit  = susieR::susie(X,Y = Y,L = L,estimate_residual_variance = estimate_residual_variance, scaled_prior_variance=prior_var, intercept=FALSE); bhat = susieR:::coef.susie(fit)[-1])
  prior_var: 0.2
  L: 10
  X: $X
  Y: $Y
  estimate_residual_variance: FALSE
  $beta_est: bhat

susie02(susie):
  prior_var: 0.2
  L: 20

susie01(susie02):
  prior_var: 0.1

susie04(susie02):
  prior_var: 0.4

susie05(susie02):
  estimate_residual_variance: TRUE

susie_auto: R(fit  = susieR::susie_auto(X,Y); bhat = susieR:::coef.susie(fit)[-1])
  X: $X
  Y: $Y
  $beta_est: bhat


BayesC: R(fit=BGLR::BGLR(y=Y,ETA=list( list(X=X,model='BayesC')), saveAt=cache))
  X: $X
  Y: $Y
  cache: file(BGLR)
  $beta_est: fit$ETA[[1]]$b

# Score modules

pred_err: R(p = mean((X %*% b - Y)^2))
  b: $beta_est
  Y: $Ytest
  X: $Xtest
  $err: p

coef_err: R(c = mean((a - b)^2))
  b: $beta_est
  a: $beta_true
  $err: c

DSC:
  define:
    simulate: en_sim, sparse, dense
    analyze: lasso, ridge, en, susie, susie02, susie04, susie05, susie01, susie_auto, varbvs, varbvsmix, BayesC
    score: pred_err, coef_err
  run: simulate * analyze * score
  exec_path: code
  R_libs: MASS, glmnet, BGLR, varbvs,
          susieR@stephenslab/susieR