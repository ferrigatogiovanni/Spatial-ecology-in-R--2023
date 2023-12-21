# measurement of RS based variability

library(terra)
library(imageRy)
library(viridis)

im.list() #list of files
sent <- im.import("sentinel.png") #sentinel_4 is a control band

#band 1 = NIR
#band 2 = red
#band 3 = green
im.plotRGB(sent, r=1, g=2, b=3)
im.plotRGB(sent, r=2, g=1, b=3) #vegetation in green and soil in purple

nir <- sent[[1]]
plot(nir)

# moving window
#focal() -> https://www.rdocumentation.org/packages/raster/versions/3.6-26/topics/focal
#calculating the sd (standard deviation)
sd3 <- focal(nir, matrix(1/9, 3, 3), fun = sd) #matrix has 9 pixels (3x3); the function (fun) is standard deviation
plot(sd3) #plotting the standard deviation of the picture

viridisc <- colorRampPalette(viridis(7))(255) #using the 7th color of viridis -> viridis(7); 255 index color; north-west part 
#has the most variability
plot(sd3, col=viridisc)

#Exercise: calculate variability in a 7x7 pixels moving window 
sd7 <- focal(nir, matrix(1/49, 7, 7), fun = sd) 
plot(sd7, col=viridisc) 

#Exercise: plot via par(mfrow() the 3x3 and the 7x7 standard deviation
par(mfrow = c(1,2))
plot(sd3, col=viridisc)
plot(sd7, col=viridisc)
#in the 3x3 we have a very local calculation while in the 7x7 moving window (bigger moving window) we will include more pixels so
#there'll be a higher variability

#Plot the original image with the 7x7
par(mfrow = c(1,2))
im.plotRGB(sent, r=2, g=1, b=3)
plot(sd7, col=viridisc)
#upper-left -> we can see the similarity (higher variability) in common
