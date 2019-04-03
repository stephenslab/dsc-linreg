# This function is used in linreg.Rmd to create a boxplot comparing
# mean squared error (MSE).
mse.boxplot <- function (dat) {
  colors <- c("orchid","skyblue","dodgerblue","limegreen","olivedrab",
              "gold","orange")
  return(ggplot(dat,aes_string(x = "fit",y = "mse.err",fill = "fit")) +
         geom_boxplot(color = "black",outlier.size = 1,width = 0.85) +
         scale_fill_manual(values = colors,guide = "none") +
         labs(x = "",y = "mean squared error") +
         theme_cowplot(font_size = 14) +
         theme(axis.line   = element_blank(),
               axis.text.x = element_text(angle = 45,hjust = 1)))
}
         
