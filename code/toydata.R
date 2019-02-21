# TO DO: Summarize the contents of this file.

# Return a matrix of samples drawn from the multivariate normal
# distribution with zero mean and covariance S, where S is defined
# below. The return value is an n x p matrix, where n the number of
# samples, and p is the number of predictors. The p x p covariance
# matrix S is 1 along the diagonal, with off-diagonal entries s, where
# s is a number between 0 and 1.
#
# Setting s = 0.5 reproduces the simulation of the predictors used in
# Example 3 of Zou & Hastie (2005).
simulate_predictors_corr <- function (n, p, s = 0.5) {
  S <- matrix(s,p,p)
  diag(S) <- 1
  return(MASS::mvrnorm(n,rep(0,p),S))
}

# Return a matrix of samples drawn from the multivariate normal
# distribution with zero mean and covariance S, where S is defined
# below. The return value is an n x p matrix, where n is the number of
# samples, and p is the number of predictors. The p x p covariance
# matrix S has entries S[i,j] = s^abs(i - j) for all i, j.
#
# Setting s = 0.5 reproduces the simulation of the predictors used in
# Examples 1 and 2 of Zou & Hastie (2005).
simulate_predictors_decaying_corr <- function (n, p, s = 0.5) {
  S <- s^abs(outer(1:p, 1:p,"-"))
  return(MASS::mvrnorm(n,rep(0,p),S))
}

# Return a matrix of samples drawn according to the procedure
# described for the predictors in Example 4 of Zou & Hastie (2005).
# The return value is a matrix with n rows and 8*p columns, where n is
# the number of samples and 8*p is the number of predictors.
simulate_predictors_grouped <- function (n, p, s = 0.1) {
  X                  <- matrix(0,n,8*p)
  X[,seq(1,3*p)]     <- rnorm(3*n*p,sd = s)
  X[,seq(3*p+1,8*p)] <- rnorm(5*n*p)
  i <- 1:p
  for (k in 1:3) {
    X[,i] <- X[,i] + rnorm(n)
    i     <- i + p
  }
  return(X)
}

# Returns outcomes y simulated from a linear regression model, y = X*b
# + e, in which the residuals e are i.i.d. normally with zero mean and
# standard deviation se.
simulate_outcomes <- function (X, b, se) {
  n <- nrow(X)
  return(X %*% b + rnorm(n,sd = se))
}

# TO DO: Fix this description.
# 
# Return a matrix of samples drawn according to the chosen scenario
# (see the "design" input argument). The three different designs are
# intended to recapitulate the three different procedures used to
# simulate the predictors in Zou & Hastie (2005).
simulate_toy_data <-
  function (n, p, design = c("corr", "decaying_corr", "grouped")) {
  design <- match.arg(design)
  if (design == "corr")
    X <- simulate_predictors_corr(n,p,0.5)
  else if (design == "decaying_corr")
    X <- simulate_predictors_decaying_corr(n,p,0.5)
  else if (design == "grouped")
    X <- simulate_predictors_grouped(n,p,0.1)
  return(X)
}
