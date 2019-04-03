# A closer look at the two susie variants---with and without estimating
# the prior variance.
library(dscrutils)
library(ggplot2)
library(susieR)
library(cowplot)

# Load the DSC results we are interested in exploring in greater detail.
dsc.dir <- "../dsc/linreg"
targets <- c("simulate.scenario","simulate.beta","fit","fit.model","mse.err")
out1 <- dscquery(dsc.dir,targets,
                 conditions = c("$(simulate.scenario) == 2",
                                "$(fit) == 'susie'"))
out2 <- dscquery(dsc.dir,targets,
                 conditions = c("$(simulate.scenario) == 2",
                                "$(fit) == 'susie_est_s0'"))

# Find the simulation with the greatest disparity in prediction error.
i <- which.max(out2$mse.err/out1$mse.err)

# Get the two fitted models.
fit1 <- out1$fit.model[[i]]
fit2 <- out2$fit.model[[i]]

# Compare the coefficients of the two fitted models.
beta1 <- coef(fit1)[-1]
beta2 <- coef(fit2)[-1]
p1 <- qplot(beta1,beta2,
            xlab = "coef (don't fit prior var)",
            ylab = "coef (fit prior var)")

# Compare the prior variances in second model against the coefficients.
s0 <- susie_get_prior_variance(fit2)
p2 <- qplot(beta2,s0,xlab = "coef",ylab = "prior variance")
