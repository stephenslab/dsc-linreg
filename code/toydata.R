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
  return(drop(X %*% b + rnorm(n,sd = se)))
}

# TO DO: Fix this description.
# 
# Return a matrix of samples drawn according to the chosen
# scenario. The three different designs are intended to recapitulate
# the three different procedures used to simulate the predictors in
# Zou & Hastie (2005).
#
simulate_toy_data <- function (scenario) {
  if (scenario == 1) {
      
    # From Zou & Hastie (2005): In Example 1, we simulated 20/20/200
    # observations and 8 predictors. We let b = (3, 1.5, 0, 0, 2,
    # 0, 0, 0) and sigma = 3. The pairwise correlation between xi and
    # xj was set to be cor(i,j) = 0.5^|i-j|.
    b      <- c(3,1.5,0,0,2,0,0,0)
    se     <- 3
    Xtrain <- simulate_predictors_decaying_corr(40,8,0.5)
    Xtest  <- simulate_predictors_decaying_corr(200,8,0.5)
  } else if (scenario == 2) {

    # From Zou & Hastie (2005): Example 2 is the same as Example 1,
    # except that bj = 0.85 for all j.
    b      <- rep(0.85,8)
    se     <- 3
    Xtrain <- simulate_predictors_decaying_corr(40,8,0.5)
    Xtest  <- simulate_predictors_decaying_corr(200,8,0.5)
  } else if (scenario == 3) {

    # From Zou & Hastie (2005): In Example 3, we simulated 100/100/400
    # observations and 40 predictors. We set b = ... and sigma = 15;
    # cor(i,j) = 0.5 for all i,j.
    b      <- rep(c(rep(0,10),rep(2,10)),2)
    se     <- 15
    Xtrain <- simulate_predictors_corr(200,40,0.5)
    Xtest  <- simulate_predictors_decaying_corr(400,40,0.5)
  } else if (scenario == 4) {
  } else
    stop("Input argument \"scenario\" should be a number between 1 and 4")

  # Simulate the training and test outcomes.
  ytrain <- simulate_outcomes(Xtrain,b,se)
  ytest  <- simulate_outcomes(Xtest,b,se)

  # Output the training and test sets.
  return(list(train = list(X = Xtrain,y = ytrain),
              test  = list(X = Xtest,y = ytest)))
}
