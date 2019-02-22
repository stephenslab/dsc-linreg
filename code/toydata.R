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

# Return training and test data simulated according one of the four
# scenarios described in Zou & Hastie (2005). The return value is a
# list object containing two elements, "train" and "test", containing
# the training and test data, respectively. Each of these list
# elements is in turn a list containing an n x p matrix of simulated
# predictors, X, and a vector of outcomes, y, of length n (n
# represents the number of samples and p represents the number of
# predictors).
simulate_toy_data <- function (scenario) {
  if (scenario == 1) {
      
    # Example 1 from Zou & Hastie (2005).
    se     <- 3
    b      <- c(3,1.5,0,0,2,0,0,0)
    Xtrain <- simulate_predictors_decaying_corr(40,8,0.5)
    Xtest  <- simulate_predictors_decaying_corr(200,8,0.5)
  } else if (scenario == 2) {

    # Example 2 from Zou & Hastie (2005).
    se     <- 3
    b      <- rep(0.85,8)
    Xtrain <- simulate_predictors_decaying_corr(40,8,0.5)
    Xtest  <- simulate_predictors_decaying_corr(200,8,0.5)
  } else if (scenario == 3) {

    # Example 3 from rom Zou & Hastie (2005).
    se     <- 15
    b      <- rep(c(rep(0,10),rep(2,10)),2)
    Xtrain <- simulate_predictors_corr(200,40,0.5)
    Xtest  <- simulate_predictors_decaying_corr(400,40,0.5)
  } else if (scenario == 4) {

    # Example 4 from Zou & Hastie (2005).
    se     <- 15
    b      <- c(rep(3,15),rep(0,25))
    Xtrain <- simulate_predictors_grouped(100,5,0.1)
    Xtest  <- simulate_predictors_grouped(400,5,0.1)
  } else
    stop("Input argument \"scenario\" should be a number between 1 and 4")

  # Simulate the training and test outcomes.
  ytrain <- simulate_outcomes(Xtrain,b,se)
  ytest  <- simulate_outcomes(Xtest,b,se)

  # Output the training and test sets.
  return(list(train = list(X = Xtrain,y = ytrain),
              test  = list(X = Xtest,y = ytest)))
}
