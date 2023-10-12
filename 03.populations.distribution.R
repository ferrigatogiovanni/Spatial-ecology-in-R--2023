# why pupulations disperse over the landscape in a certain number?
# (GDAL -> https://gdal.org/index.html, GDAL is now inside the package TERRA) 

library(sdm)
library(terra)

system.file("external/species.shp", package="sdm") #importing the file species that is located inside the package sdm
file <- system.file("external/species.shp", package="sdm") 
file #returns the location of the file (species)

# looking at the set
species <- vect(file)

# looking at the occurrences
specie$Occurence # how to see the presences (1 present, 0 absent)

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
par(frow <- c(1,2))
