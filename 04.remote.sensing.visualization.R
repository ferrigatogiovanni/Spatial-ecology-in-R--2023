#remote sensing for ecosystem monitoring

library(devtools)
library(terra)

#install_github --> https://www.rdocumentation.org/packages/devtools/versions/1.13.6/topics/install_github
library(imageRy)

#now we will use the package
im.list() 

#we are gonna use sentinel-2 --> https://sentinels.copernicus.eu/web/sentinel/missions/sentinel-2
#importing the band 2 (see sentinel-2 bands --> https://en.wikipedia.org/wiki/Sentinel-2)
b2 <- im.import("sentinel.dolomites.b2.tif")
