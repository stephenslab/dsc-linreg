   pdat   <- subset(out,simulate.scenario == i)

# TO DO: Explain here what this function does, and how to use it.
mse.boxplot <- function (dat) {
  colors <- c("orchid","skyblue","dodgerblue","limegreen","gold","orange")
  return(ggplot(pdat,aes(x = fit,y = mse.err,fill = fit)) +
         geom_boxplot(color = "black",outlier.size = 1,width = 0.6) +
         scale_fill_manual(values = colors,guide = "none") +
         labs(x = "",y = "mean squared error") +
         theme_cowplot(font_size = 12) +
         theme(axis.line   = element_blank(),
               axis.text.x = element_text(angle = 45,hjust = 1)))
}
         
