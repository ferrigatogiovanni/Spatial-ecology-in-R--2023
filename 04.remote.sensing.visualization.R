#remote sensing for ecosystem monitoring
#(remote sensing in ecology and conservation -> see website)

library(devtools) #you need it in order to use install_github
library(terra)

#install_github("ducciorocchini/imageRy") --> https://www.rdocumentation.org/packages/devtools/versions/1.13.6/topics/install_github
library(imageRy)

#now we will use the package, first we are gonna list the data
im.list() 

#we are gonna use sentinel-2 --> https://sentinels.copernicus.eu/web/sentinel/missions/sentinel-2
#importing the band 2, blue band (see sentinel-2 bands --> https://en.wikipedia.org/wiki/Sentinel-2)
b2 <- im.import("sentinel.dolomites.b2.tif") #b2 is the blue wavelength; we import the image with the function im.import()
b2 #you can see the information about the image
#changing color to b2
clblue <- colorRampPalette(c("dark grey","grey","light grey")) (100)
plot(b2, col = clblue)

#import the green band from Sentinel-2 (band 3)
b3 <- im.import("sentinel.dolomites.b3.tif") #b2 is the green wavelength
plot(b3, col = clblue)

#what is reflectance?
