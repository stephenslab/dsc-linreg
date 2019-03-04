# This file contains functions to predict outcomes given various
# fitted models.

# Use the fitted ridge regression model, "ridge", to predict n continuous
# outcomes given an n x p matrix of observations X. The return value is a
# vector of length n.
predict_ridge <- function (ridge, X)
  predict_elastic_net(ridge,X)

# Use the fitted Lasso model, "lasso", to predict n continuous
# outcomes given an n x p matrix of observations X. The return value is a
# vector of length n.
predict_lasso <- function (lasso, X)
  predict_elastic_net(lasso,X)

# Use the fitted Elastic Net model, "en", to predict n continuous
# outcomes given an n x p matrix of observations X. The return value is a
# vector of length n.
predict_elastic_net <- function (en, X)
  return(drop(predict(en$fit,X,en$cv$lambda.min)))

# Use the fitted varbvs model, "fit", to predict n continuous outcomes
# given an n x p matrix of observations X. The return value is a
# vector of length n.
predict_varbvs <- function (fit, X)
  return(predict(fit,X))
