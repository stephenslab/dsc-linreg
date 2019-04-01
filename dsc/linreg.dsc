# TO DO: Give overview of DSC here.

# simulate modules
# ================
# TO DO: Give overview of simulate modules here.

# TO DO: Add comments here describing what this module does.
toydata: modules/simulate/toydata.R
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
# TO DO: Give overview of fit modules here.

# TO DO: Add comments here explaining what this module does.
ridge: modules/fit/ridge.R
  X:      $X
  y:      $y
  $model: out

# TO DO: Add comments here explaining what this module does.
lasso: modules/fit/lasso.R
  X:      $X
  y:      $y
  $model: out

# TO DO: Add comments here explaining what this module does.
elastic_net: modules/fit/elastic_net.R
  X:      $X
  y:      $y
  $model: out

# TO DO: Add comments here explaining what this module does.
susie: modules/fit/susie.R
  X:      $X
  y:      $y
  $model: out

# TO DO: Add comments here explaining what this module does.
varbvs: modules/fit/varbvs.R
  X:      $X
  y:      $y
  $model: out

# TO DO: Add comments here explaining what this module does.
varbvsmix: modules/fit/varbvsmix.R
  X:      $X
  y:      $y
  $model: out

# predict modules
# ===============
# TO DO: Give overview of predict modules here.

# TO DO: Add comments here explaining what this module does.
predict_ridge: modules/predict/predict_ridge.R
  X:     $Xtest
  model: $model
  $yest: y

# TO DO: Add comments here explaining what this module does.
predict_lasso: modules/predict/predict_lasso.R
  X:     $Xtest
  model: $model
  $yest: y

# TO DO: Add comments here explaining what this module does.
predict_elastic_net: modules/predict/predict_elastic_net.R
  X:     $Xtest
  model: $model
  $yest: y

# TO DO: Add comments here explaining what this module does.
predict_susie: modules/predict/predict_susie.R
  X:     $Xtest
  model: $model
  $yest: y

# TO DO: Add comments here explaining what this module does.
predict_varbvs: modules/predict/predict_varbvs.R
  X:     $Xtest
  model: $model
  $yest: y

# TO DO: Add comments here explaining what this module does.
predict_varbvsmix: modules/predict/predict_varbvsmix.R
  X:     $Xtest
  model: $model
  $yest: y

# score modules
# =============
# TO DO: Give overview of score modules here.  

# TO DO: Add comments here explaining what this module does.
mse: modules/score/mse.R
  y:    $ytest
  yest: $yest
  $err: err

DSC:
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
    score:    mse
  run: simulate * analyze * score
