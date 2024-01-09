# Final script including all different scripts during lectures 

#----------------------------

# Summary:
# 01 Beginning
# 02.1 Population density
# 02.2 Population distribution
# 03 Community multivariate analysis 

#----------------------------

# 01 Beginning

## First lecture

# R as a calculator
2 + 3 

# Assign to an object
zima <- 2 + 3 #assigning with an operation
gio <- 23 #assigning directly a value
final <- zima * gio

#square of final
final^2

# creating an array and assign it to an object
sophi <- c(10, 20, 30, 50, 70) # microplastics # functions have parentheses and inside them there are arguments 
paula <- c(100, 500, 600, 1000, 2000) # people
plot(paula, sophi)
plot(paula, sophi, xlab = "number of people", ylab = "microplastics") #labelling the x and y axis

#overwriting an object
people <- paula
microplastics <- sophi

#modifyng the plot
plot(people, microplastics, pch = 19) #pch = typology of symbol
plot(people, microplastics, pch = 19, cex = 2) #cex = dimension of the symbol
plot(people, microplastics, pch = 19, cex = 2, col = "blue") #col = colour 

#----------------------------

# 02.1 Population density

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
points(bei, cex = .2) #how to add a plot to the current one without erasing the first

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

#----------------------------

# 02.2 Population distribution

# why pupulations disperse over the landscape in a certain number?
# (GDAL -> https://gdal.org/index.html, GDAL is now inside the package TERRA) 

library(sdm)
library(terra)

system.file("external/species.shp", package="sdm") #importing the file species that is located inside the package sdm
file <- system.file("external/species.shp", package="sdm") 
file #returns the location of the file (species)

# looking at the set
species <- vect(file) #in this file there are vectors 

# looking at the occurrences
specie$Occurence # how to see the presences of the specie (1 present, 0 absent)

# plot
plot(species)

# selecting presences
pres <- species[species$Occurrence == 1,]
plot(pres)

# selecting absences
abse <- species[species$Occurrence == 0,]
plot(abse)

# selecting presences 
plot(species[species$Occurrence == 1,],col='blue',pch=16) #selects the species that are present
plot(species[species$Occurrence == 0,],col='red',pch=16) #selects the species that are absent

# putting two plots near each others
par(mfrow = c(1,2))
plot(pres)
plot(abse)

# it erases the previous plots/graphics
dev.off()

# plotting presences and absences altogether
plot(pres)
points(abse, col = "blue")

# how to check the path
path <- system.file("external", package="sdm") 

# predictors: environmental variables
# elevation predictor 
elev <- system.file("external/elevation.asc", package="sdm")
elev
elevmap <- rast(elev)    #from Terra package (rast are images)
plot(elevmap)
points(pres, cex = .5) #adding the presences 

# temperature predictor
temp <- system.file("external/temperature.asc", package="sdm")
temp #it shows the path to the file temperature
tempmap <- rast(temp)
plot(tempmap)
points(pres, cex = .5)

# vegetation predictor
vege <- system.file("external/vegetation.asc", package="sdm")
vegemap <- rast(vege)
plot(vegemap)
points(pres, cex = .5)

# precipitation predictor
prec <- system.file("external/precipitation.asc", package="sdm")
precmap <- rast(prec)
plot(precmap)
points(pres, cex = .5)

# final multiframe 
par(mfrow = c(2,2))

plot(elevmap)
points(pres, cex = .5)

plot(tempmap)
points(pres, cex = .5)

plot(vegemap)
points(pres, cex = .5)

plot(precmap)
points(pres, cex = .5)

#----------------------------

# 03 Community multivariate analysis 

#https://cran.r-project.org/web/packages/vegan/vegan.pdf
library(vegan)

data(dune) #see data() function
dune
head(dune) #just to see the first 6 rows of the data

ord <- decorana(dune) #see Detrended correspondence analysis (DCA)
?decorana
ord

#we want to measure the length of the axis
ldc1 <- 3.7004 #length of DC1
ldc2 <- 3.1166 
ldc3 <- 1.30055 
ldc4 <- 1.47888

#total length
total = ldc1 + ldc2 + ldc3 + ldc4

#calculating the percentage on the total for each ldc
pldc1 = ldc1 * 100 / total
pldc2 = ldc2 * 100 / total
pldc3 = ldc3 * 100 / total
pldc4 = ldc4 * 100 / total

pldc1; pldc2 
pldc1 + pldc2 #summing the first 2 to find the lenth of the axis

plot(ord)
#see bromus hordeaceus (Bromhord in the plot)
#on the other side: salix repens (Salirepe in the plot)
#from the plot you can see the different plants (based on the position in the plot)

#----------------------------

# 03.2
