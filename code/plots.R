# Compute the mean squared error (MSE)
compute.relative.mse <- function (dat) {

  # Initialize storage for the result.
  n    <- nrow(dat)
  rmse <- rep(0,n)
    
  # Create a new column, "experiment", combining the simulate module,
  # scenario and seed.
  dat <- transform(dat,experiment = paste(simulate,simulate.scenario,
                                          simulate.seed,sep = "-"))
  
  # Compute the relative mean squared error; repeat for each
  # combination of simulate module, scenario and seed ("experiment").
  for (i in dat$experiment) {
    rows       <- which(dat$experiment == i)
    mse.ridge  <- subset(dat,experiment == i & fit == "ridge")$mse.err
    rmse[rows] <- dat[rows,"mse.err"] / mse.ridge
  }

  return(rmse)
}

# This function is used in linreg.Rmd to create a boxplot comparing
# mean squared error (MSE) relative to ridge regression.
rmse.boxplot <- function (dat, plot.title = "") {
  colors <- c("skyblue","dodgerblue","limegreen","gold","orange")
  dat    <- subset(dat,fit != "ridge")
  return(ggplot(dat,aes_string(x = "fit",y = "rmse",fill = "fit")) +
         geom_boxplot(color = "black",outlier.size = 1,width = 0.85) +
         scale_fill_manual(values = colors,guide = "none") +
         labs(x = "",y = "increase in MSE",
              title = plot.title) +
         theme_cowplot(font_size = 14) +
         theme(axis.line   = element_blank(),
               axis.text.x = element_text(angle = 45,hjust = 1)))
}
         
