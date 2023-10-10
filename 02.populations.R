# code related to population ecology

# how to install a code
# a code is needed for point pattern analysis
install.packages("spatstat")

# how to check if a code has been correctly installed
library(spatstat)

# let's use the bei data (dataset) (trees in the tropical area forests)
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

# passing from points to a continuous surface
densitymap <- density(bei) #now dealing with pixels
plot(densitymap)
points(bei, cex = .2) #how to add a plot to the current one without erasing the first one
#how to change color to the plot 
c1 <- colorRampPalette(c("black", "red", "orange", "yellow"))(100)
plot(densitymap, col = c1)


