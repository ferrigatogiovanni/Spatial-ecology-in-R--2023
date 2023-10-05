# code related to population ecology

# how to install a code
# a code is needed for point pattern analysis
install.packages("spatstat")

# how to check if a code has been correctly installed
library(spatstat)

# let's use the bei data (dataset)
bei

# plotting the data
plot(bei)

# changing the dimension - cex
plot(bei, cex = 0.5)

# changing the symbols - pch (there are many types)
plot(bei, cex = 0.5, pch = 19)

# additional datasets
bei.extra
plot(bei.extra)

# let's use only a part of the dataset: elev ($ is linking elev with bei.extra)
plot(bei.extra$elev)
elevation <- bei.extra$elev   #creating an object called elevation
plot(elevation)
bei.extra

# second method to select elements
elevation2 <- bei.extra[[1]] #it's the same as we did before (bei.extra$elev)
plot(elevation2)
