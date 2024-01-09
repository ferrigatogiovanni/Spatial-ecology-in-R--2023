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
