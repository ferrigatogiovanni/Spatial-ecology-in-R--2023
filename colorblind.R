# simulating colour blind vision 

library(devtools)
library(colorblindr)
library(ggplot2)

fig <- ggplot(iris, aes(Sepal.Length, fill = Species)) + geom_density(alpha = 0.7)
fig

cvd_grid(fig)
