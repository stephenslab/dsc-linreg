#' @title perform simulations under scenarios from Zhou and Hastie (2005)
#' @details the value of n is set to the sum of the train+validate sample sizes from the paper
#' @param scenario name of scenario (p312 of paper)
en_sim = function(scenario = c("eg1", "eg2", "eg3", "eg4")) {
  scenario = match.arg(scenario)

  if (scenario == "eg1" || scenario == "eg2") {
    n = 40
    p=8
    beta = rep(0,p)
    beta[1] = 3
    beta[2] = 1.5
    beta[5] = 2
    sigma = 3
    design = "decreasing_corr"
  }

  if (scenario == "eg2") {
    beta = rep(0.85,p)
  }

  if (scenario == "eg3") {
    n = 200
    p = 40
    beta = c(rep(0,10),rep(2,10),rep(0,10),rep(2,10))
    sigma = 15
    design = "equal_corr"
  }

  if (scenario == "eg4") {
    n = 100
    p = 40
    beta = c(rep(3,15),rep(0,25))
    sigma = 15
    design = "grouped"
  }

  X = X_sim(n,p,design)
  Xtest = X_sim(n,p,design)

  # 2. generate response vector
  epsilon = rnorm(n, mean = 0, sd = sigma)
  Y = X %*% beta + epsilon
  Ytest = Xtest %*% beta

  return(list(Y=Y,X=X,beta=beta,Xtest=Xtest,Ytest=Ytest))
}


# simulate with independent covariates, and prescribed pve and pi0
simple_sim_regression = function(n,p,pve,pi0){
  beta = rnorm(p)
  gamma = rep(0,p)
  while(sum(gamma)==0){
    gamma = rbinom(p,1,1-pi0) #select which variables to include
  }

  beta = beta*gamma

  X = X_sim(n,p,"independent")
  Xtest = X_sim(n,p,"independent")

  Yhat = X %*% beta
  sigma = sqrt(var(Yhat)*(1-pve)/pve)

  epsilon = rnorm(n, mean = 0, sd = sigma)
  Y = Yhat + epsilon
  Ytest = Xtest %*% beta

  return(list(Y=Y,X=X,beta=beta,Xtest=Xtest,Ytest=Ytest))
}

# simulate design matrix X under different scenarios
# specifically the scenarios from Zhou and Hastie (2005)
X_sim = function(n,p,design = c("decreasing_corr", "equal_corr", "grouped","independent")) {
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

    q = c(round(p/8),round(p/4),round(3*p/8),p) # this defines the groups in the paper
    E = matrix(rnorm(n * p, mean = 0, sd = 0.1),nrow = n)
    E[,(q[3]+1):q[4]] = E[,(q[3]+1):q[4]]*10 # this last group is N(0,1)

    # group 1: Z1 + Normal(0, 0.01)
    X[, 1:q[1]] = Z[,1]
    # group 2: Z2 + Normal(0, 0.01)
    X[, (q[1]+1):q[2]] = Z[,2]
    # group 3: Z3 + Normal(0, 0.01)
    X[, (q[2]+1):q[3]] = Z[,3]
    X = X + E
  }
  if (design == "independent") {
    X = matrix(rnorm(n*p), nrow = n, ncol = p)
  }

  return(X)

}
