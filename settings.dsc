en_sim : simulate.R + R(d = en_sim(scenario))
  scenario: eg1, eg2, eg3, eg4
  $Y: d$Y
  $X: d$X
  $Ytest: d$Ytest
  $Xtest: d$Xtest

sparse: simulate.R + R(d=simple_sim_regression(n,p,pve,pi0))
  scenario: sparse
  n: 100
  p: 100
  pve: 0.5
  pi0: 0.9
  $Y: d$Y
  $X: d$X
  $Ytest: d$Ytest
  $Xtest: d$Xtest

dense(sparse):
  scenario: dense
  pi0: 0

varbvsmix: R(bhat = rnorm(5))
  X: $X
  Y: $Y
  $beta_est: bhat

sq_err : R(mse = mean( (X %*% b - Y)^2))
  b: $beta_est
  Y: $Ytest
  X: $Xtest
  $error: mse

DSC:
  define:
     simulate: en_sim, sparse, dense
     analyze: varbvsmix
     score: sq_err
  run: simulate * analyze * score
  exec_path: code
  output: dsc_result
