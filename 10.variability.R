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
im.plotRGB(sent, r=2, g=1, b=3)

nir <- sent[[1]]
plot(nir)

# moving window
#focal() -> https://www.rdocumentation.org/packages/raster/versions/3.6-26/topics/focal
#calculating the sd (standard deviation)
sd3 <- focal(nir, matrix(1/9, 3, 3), fun = sd) #matrix has 9 pixels (1/9); the function (fun) is standard deviation
plot(sd3) #plotting the standard deviation of the picture

viridisc <- colorRampPalette(viridis(7))(255) #using the 7th color of viridis -> viridis(7)
plot(sd3, col=viridisc)
