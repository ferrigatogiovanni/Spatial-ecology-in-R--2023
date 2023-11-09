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
