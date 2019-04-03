library(dscrutils)
dsc <- dscquery("linreg",c("simulate.y","simulate.beta"))
a <- sapply(dsc$simulate.beta,function (x) mean(abs(x[x != 0])))
b <- sapply(dsc$simulate.y,function (x) var(x))
