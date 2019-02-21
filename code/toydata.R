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

# Simulate design matrix X under different scenarios, specifically the
# scenarios from Zhou and Hastie (2005).
X_sim = function(n, p, design = c("decreasing_corr", "equal_corr",
                                  "grouped", "independent")) {
  design = match.arg(design)

  if (design == "decreasing_corr") {
    Sigma = 0.5 ^ abs(outer(1:p, 1:p, FUN = "-"))
    X = MASS::mvrnorm(n = n, rep(0, p), Sigma)
  }

  if (design == "equal_corr") {
    Sigma = matrix(data = 0.5,
                   nrow = p,
                   ncol = p)
    diag(Sigma) = 1
    X = MASS::mvrnorm(n = n, rep(0, p), Sigma)
  }
  if (design == "grouped") {
    X = matrix(data = 0, nrow = n, ncol = p)
    Z = matrix(rnorm(n*3, mean = 0, sd = 1),nrow=n,ncol=3)

    # This defines the groups in the paper.
    q = c(round(p/8),round(p/4),round(3*p/8),p) 
    E = matrix(rnorm(n * p, mean = 0, sd = 0.1),nrow = n)

    # This last group is N(0,1).
    E[,(q[3]+1):q[4]] = E[,(q[3]+1):q[4]]*10 

    # group 1: Z1 + Normal(0, 0.01)
    # group 2: Z2 + Normal(0, 0.01)
    # group 3: Z3 + Normal(0, 0.01)
    X[, 1:q[1]] = Z[,1]
    X[, (q[1]+1):q[2]] = Z[,2]
    X[, (q[2]+1):q[3]] = Z[,3]
    X = X + E
  }
  if (design == "independent") {
    X = matrix(rnorm(n*p), nrow = n, ncol = p)
  }

  return(X)
}
 
