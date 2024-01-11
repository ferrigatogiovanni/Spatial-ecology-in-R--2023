# simulating colour blind vision 

library(devtools)
library(colorblindr)
library(ggplot2)

iris
head(iris)

fig <- ggplot(iris, aes(Sepal.Length, fill = Species)) + geom_density(alpha = 0.7)
fig

# vision by different colour blind people
cvd_grid(fig)

names(iris)
# doing the same for Sepal.Width
fig2 <- ggplot(iris, aes(Sepal.Width, fill = Species)) + geom_density(alpha = 0.7)
fig2
cvd_grid(fig2)
