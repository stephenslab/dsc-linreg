# TO DO: Give overview of DSC here.

# simulate modules
# ================
# TO DO: Give overview of simulate modules here.

# TO DO: Add comments here describing what this module does.
toydata: toydata.R
  seed:     R{1:5}
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
ridge: ridge.R
  X:      $X
  y:      $y
  $model: out

# TO DO: Add comments here explaining what this module does.
lasso: lasso.R
  X:      $X
  y:      $y
  $model: out

# TO DO: Add comments here explaining what this module does.
elastic_net: elastic_net.R
  X:      $X
  y:      $y
  $model: out
  
# predict modules
# ===============
# TO DO: Give overview of predict modules here.

# TO DO: Add comments here explaining what this module does.
predict_ridge: predict_ridge.R
  X:     $Xtest
  model: $model
  $yest: y

# TO DO: Add comments here explaining what this module does.
predict_lasso: predict_lasso.R
  X:     $Xtest
  model: $model
  $yest: y

# TO DO: Add comments here explaining what this module does.
predict_elastic_net: predict_elastic_net.R
  X:     $Xtest
  model: $model
  $yest: y

# score modules
# =============
# TO DO: Give overview of score modules here.  

# TO DO: Add comments here explaining what this module does.
mse: mse.R
  y:    $ytest
  yest: $yest
  $err: err

DSC:
  define:
    simulate: toydata
    fit:      ridge, lasso, elastict_net
    predict:  predict_ridge, predict_lasso, predict_elastic_net
    analyze:  ridge * predict_ridge, 
              lasso * predict_lasso, 
              elastic_net * predict_elastic_net
    score:    mse
  run: simulate * analyze * score
