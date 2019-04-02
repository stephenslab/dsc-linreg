# TO DO: Briefly explain here what this script is for.
library(dscrutils)
library(ggplot2)
library(cowplot)

# Extract the results.
out <- dscquery("linreg",targets = c("simulate.scenario","fit","mse.err"))
out <- transform(out,
                 simulate.scenario = factor(simulate.scenario,1:4),
                 fit = factor(fit,c("ridge","lasso","elastic_net",
                                    "susie","varbvs","varbvsmix")))

# Create boxplots summarizing the results.
p <- vector("list",4)
for (i in 1:4) {
   pdat   <- subset(out,simulate.scenario == i)
   p[[i]] <- ggplot(pdat,aes(x = fit,y = mse.err,fill = fit)) +
             geom_boxplot(color = "black",outlier.size = 1,outlier.shape = 4,
                          width = 0.6) +
             scale_fill_manual(
                 values = c("orchid","skyblue","dodgerblue","limegreen",
                            "gold","orange"),
                 guide = "none") +
             labs(x = "",y = "mean squared error",
                  title = paste("scenario",i)) +
             theme_cowplot(font_size = 12) +
             theme(axis.line   = element_blank(),
                   axis.text.x = element_text(angle = 45,hjust = 1))
}
p <- do.call(plot_grid,p)
