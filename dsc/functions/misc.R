# Generates a vector of n points that are equally spaced on the
# logarithmic scale. Note that x and y should be positive numbers.
logspace <- function (x, y, n)
  2^seq(log2(x),log2(y),length = n)

# TO DO: Explain here what this function does, and how to use it.
simplelr <- function (X, y) {
  X <- scale(X,center = TRUE,scale = FALSE)
  y <- y - mean(y)
  return(drop(y %*% X) / apply(X,2,var))
}

# TO DO: Explain here what this function does, and how to use it.
#
# Try to select a reasonable set of standard deviations that should
# be used for the mixture model based on the values of x. This is
# code is based on the autoselect.mixsd function from the ashr
# package.
#
selectmixsd <- function (x, k) {
  smin <- 1/10
  if (all(x^2 < 1))
    smax <- 1
  else
    smax <- 2*sqrt(max(x^2 - 1))
  return(c(0,logspace(smin,smax,k - 1)))
}
