# pipeline variables
# $Y an n vector of outcomes
# $X an n by p matrix of covariates
# $beta_true an n vector of the true value of the covariate coefficients (beta)
# $beta_est an n vector of estimated values beta
# $error a scalar measure of accuracy

# module groups
#
# simulate: -> $Y, $X, $beta_true, $Xtest
# analyze: $Y, $X -> $beta_est
# score: $beta_est, $beta_true -> $error


en_sim : en_sim.R + R(d = en_sim(scenario))
  scenario: eg1, eg2, eg3, eg4
  $Y: d$Y
  $X: d$X
  $beta_true: d$beta
  $Xtest: d$Xtest

lasso : glmnet_fit.R
  alpha: 1
  X: $X
  Y: $Y
  $beta_est: bhat

ridge : glmnet_fit.R
  alpha: 0
  X: $X
  Y: $Y
  $beta_est: bhat

en : glmnet_fit.R
    alpha: 0.5
    X: $X
    Y: $Y
    $beta_est: bhat

varbvs: R(fit=varbvs::varbvs(X,Z=NULL,y=Y))
  X: $X
  Y: $Y
  $beta_est: fit$beta

susie: R(fit=susieR::susie(X,Y=Y,L=L); bhat = susieR:::coef.susie(fit))
    L: 10
    X: $X
    Y: $Y
    $beta_est: bhat

susie2: R(fit=susieR::susie(X,Y=Y,L=L); bhat = susieR:::coef.susie(fit))
    L: 20
    X: $X
    Y: $Y
    $beta_est: bhat

sq_err : R(mse = mean( (X %*% (a-b))^2))
  a: $beta_est
  b: $beta_true
  X: $Xtest
  $error: mse

DSC:
  define:
     simulate: en_sim
     analyze: lasso, ridge, en, susie, susie2, varbvs
     score: sq_err
  run: simulate * analyze * score
  exec_path: code
  output: dsc_result
