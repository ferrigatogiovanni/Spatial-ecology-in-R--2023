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
points(bei, cex = .2) #how to add a plot to the current one without erasing the firstòòòòòòòòòòòòòòòòççççç@@@@@@@

# how to change color to the plot (package -> see viridis color maps on IT)
c1 <- colorRampPalette(c("black", "red", "orange", "yellow"))(100)
plot(densitymap, col = c1)
c2 <- colorRampPalette(c("cornflowerblue","cyan","blue","darkorchid"))
plot(densitymap, col = c2)  

plot(bei.extra)
elev <- bei.extra[[1]] # or you can use bei.extra$elev
plot(elev) # you are plotting the elevation of the area 

# multiframe 
par(mfrow = c(1,2)) # we are putting two plots next to each other (1 row, 2 columns)
plot(densitymap)
plot(elev)

par(mfrow = c(2,1)) # we are putting the second plot under the first one (2 row, 1 columns)
plot(densitymap)
plot(elev) 

par(mfrow = c(1,3))
plot(bei)
plot(densitymap)
plot(elev)  # we can observe that the higher elevation corresponds to the lower density
