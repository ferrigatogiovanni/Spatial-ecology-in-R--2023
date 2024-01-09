# PCA -> principal components analysis

library(imageRY)
library(terra)
library(viridis)

im.list()

sent <- im.import("sentinel.png")

pairs(sent) #3rd row, 2nd column -> high correlation

#perform PCA on sent
sentpc <- im.pca2(sent)
sentpc

pc1 <-sentpc$PC1 #selecting just the first image
viridisc <- colorRampPalette(viridis(7))(255)
plot(pc1, col=viridisc)

#Calculating standard deviation ontop of pc1
pc1sd3 <- focal(pc1, matrix(1/9, 3, 3), fun=sd)
plot(pc1sd3, col=viridisc)

pc1sd7 <- focal(pc1, matrix(1/49, 7, 7), fun=sd)
plot(pc1sd7, col=viridisc)

#plotting everything alltoghether
par(mfrow = c(2,3))
im.plotRGB(sent, 2, 1, 3)
#sd from the variability script
plot(sd3, col=viridisc)
plot(sd7, col=viridisc)
plot(pc1, col=viridisc)
plot(pc1sd3, col=viridisc)
plot(pc1sd7, col=viridisc)

#stacking all the standard deviation layers (sd3, sd7, pc1sd3 and pc1sd7)
sdstack <- c(sd3, sd7, pc1sd3, pc1sd7)
names(sdstack) <- c("sd3", "sd7", "pc1sd3", "pc1sd7")
plot(sdstack, col=viridisc)
#sd is representing the amount of variability of a moving window (7x7 is more blurry because the variability in each pixel is 
#higher)
