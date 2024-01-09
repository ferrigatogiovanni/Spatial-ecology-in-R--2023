#remote sensing for ecosystem monitoring
#(remote sensing in ecology and conservation -> see website)
# RS data

library(devtools) #you need it in order to use install_github
library(terra)

#install_github("ducciorocchini/imageRy") --> https://www.rdocumentation.org/packages/devtools/versions/1.13.6/topics/install_github
library(imageRy)

#now we will use the package, first we are gonna list the data
im.list() 

#we are gonna use sentinel-2 --> https://sentinels.copernicus.eu/web/sentinel/missions/sentinel-2
#download sentinel-2 data -> https://www.youtube.com/watch?v=KA2L4bDmo98
#importing the band 2, blue band (see sentinel-2 bands --> https://en.wikipedia.org/wiki/Sentinel-2)
b2 <- im.import("sentinel.dolomites.b2.tif") #b2 is the blue wavelength; we import the image with the function im.import()
b2 #you can see the information about the image (WGS 84 / UTM zone 32N -> https://it.wikipedia.org/wiki/WGS84; Italy is is zones 32 and 33)
#changing color to b2
cl <- colorRampPalette(c("black","grey","light grey")) (100) #the darkest parts are the one that absorb the blue, the lighter are 
#the one that reflect the blue
plot(b2, col = cl)

#import the green band from Sentinel-2 (band 3)
b3 <- im.import("sentinel.dolomites.b3.tif") #b3 is the green wavelength
plot(b3, col = cl)

#import the red band from Sentinel-2 (band 4)
b4 <- im.import("sentinel.dolomites.b4.tif") #b4 is the red wavelength
plot(b4, col = cl)

#import the NIR band from Sentinel-2 (band 8) (NIR -> near infrared)
b8 <- im.import("sentinel.dolomites.b8.tif") #b4 is the NIR wavelength
plot(b8, col = cl)

#multiframe; plotting the different band all together
?par
par(mfrow = c(2,2))
plot(b2, col = cl)
plot(b3, col = cl)
plot(b4, col = cl)
plot(b8, col = cl)

#stack images (a simpler way to plot all the 4 bands)
stacksent <- c(b2, b3, b4, b8)
dev.off() #closing previous devices(in this case plots)
plot(stacksent, col = cl)

#plotting just the 4th element = b8
plot(stacksent[[4]], col = cl)

#plot in a multiframe the bands with different color ramps
clblue <- colorRampPalette(c("dark blue","blue","light blue")) (100)
plot(b2, col = clblue)

clgreen <- colorRampPalette(c("dark green","green","light green")) (100)
plot(b3, col = clgreen)

clred <- colorRampPalette(c("dark red","red","pink")) (100)
plot(b4, col = clred)

clnir <- colorRampPalette(c("brown","orange","yellow")) (100)
plot(b2, col = clnir)

par(mfrow = c(2,2))
plot(b2, col = clblue)
plot(b3, col = clgreen)
plot(b4, col = clred)
plot(b8, col = clnir)

#RGB space (see RGB colour model) (remember that stacksent <- c(b2, b3, b4, b8))
#stacksent: 
#band2 blue element 1, stacksent[[1]]
#band3 green element 2, stacksent[[2]]
#band4 red element 3, stacksent[[3]]
#band8 NIR element 4, stacksent[[4]]
im.plotRGB(stacksent, r = 3, g = 2, b = 1) #assining the bands to the colors 
#(we can only assign 3 colours: band4, band3, band2 -> R, G, B)

# we shift by one and use band8 and not band2 anymore (band8, band4, band3 -> R, G, B)
im.plotRGB(stacksent, r = 4, g = 3, b = 2) #using infra-red on top of the red component

#changing the position of the infra-red 
im.plotRGB(stacksent, r = 3, g = 4, b = 2) #(band4, band8, band3 -> R, G, B); the infra-red enlight the green component

#using infra-red in the blue component
im.plotRGB(stacksent, r = 3, g = 2, b = 4) #all the vegetation became blue; with this you can enhance the cities and they will be yellow

#
?pairs
pairs(stacksent)
#for the infra-red the correlation is lower than the others bands
#the histogram shows the reflectance values of each band

#NIR is highly reflected by a tree (pixel with high reflactance), while RED is quite absorbed so the reflectance will not be high (pixel with low reflactance)
#we can compute the difference between the the values of reflactance (NIR reflactance - RED reflactance = 80 - 30)
#if the tree is suffering the value of NIR reflactance will be lower and the RED reflactance will be higher than before since the red is not absorbed
#in this case the difference changes -> NIR reflactance - RED reflactance = 50 - 80
#healthy and suffering trees reflect and absorb light differently -> we can dectect healthy from suffering forests


