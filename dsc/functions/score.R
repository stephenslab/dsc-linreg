# Return the mean squared error between the observed values ("obs")
# and the predicted, or "fitted," values.
mse <- function (obs, fitted)
  mean((obs - fitted)^2)

# Return the mean absolute error between the observed values ("obs")
# and the predicted, or "fitted," values.
mae <- function (obs, fitted)
  mean(abs(obs - fitted))
