#vegetation indices

library(terra)
library(imageRy)
library()
library()

im.list()
#NASA Earth observatory -> you can search the file "matogrosso_ast_2006209_lrg.jpg" on thw website
#importing the file (matogrosso) 
m1992 <- im.import("matogrosso_l5_1992219_lrg.jpg") #earth resolution at 30 m
m2006 <- im.import("matogrosso_ast_2006209_lrg.jpg") 
#we know that bands are: 1 = NIR, 2 = RED , 3 = GREEN

#plotting with RGB
im.plotRGB(m1992, r = 1, g = 2, b = 3)
#or 
im.plotRGB(m1992, 1, 2, 3) #you can omit r = , g = and b =)
im.plotRGB(m1992, 2, 1, 3) #NIR associated with the green band (now the green is gonna be enhanced)

im.plotRGB(m1992, 2, 3, 1) #use the yellow to enlight something by putting the NIR over the green (the yellow in the plot is barren land)
im.plotRGB(m2006, 2, 3, 1) #we can obseve the differences from the last image in 1992 (the yellow is barren land -> we can see the deforestation)

#build a multiframe with 1992 and 2006 images
par(mfrow = c(1,2))
im.plotRGB(m1992, 2, 3, 1) 
im.plotRGB(m2006, 2, 3, 1)
#by doing this we can easily see the differences between 1992 and 2006 in the covered area (which has decrease a lot)

plot(m1992[[1]]) #plotting the first band (which is NIR) -> the range on the right is from 0 to 256
#binary code -> 0 or 1 (1 bit = 2 informations; 2 bit = 4 informations; 4 bit = 1 informations)
#most images are stored in 8 bits (8^2 = 256 informations)
#computing reflectance using bits
#NIR is highly reflected by a tree (pixel with high reflactance), while RED is quite absorbed so the reflectance will not be high (pixel with low reflactance)
#we can compute the difference between the the values of reflactance (NIR reflactance - RED reflactance = 80 - 30 = DVI)
#if the tree is suffering the value of NIR reflactance will be lower and the RED reflactance will be higher than before since the red is not absorbed
#in this case the difference changes -> NIR reflactance - RED reflactance = 50 - 80 = DVI
#healthy and suffering trees reflect and absorb light differently -> we can dectect healthy from suffering forests

#DVI = NIR - RED
#(bands: 1 = NIR, 2 = RED , 3 = GREEN)
#calculating DVI of 1992
dvi1992 = m1992[[1]]-m1992[[2]]
plot(dvi1992) #the values under 0 (on the right) are barren soils or suffering plants
c1 <- colorRampPalette(c("dark blue", "yellow", "red", "black"))(100)
plot(dvi1992, col = c1) #the darkest colour represent the healtier part of the forest
#calculating DVI of 2006
dvi2006 = m2006[[1]]-m2006[[2]]
plot(dvi1992, col = c1) #the healtier vegetation is not high as before
