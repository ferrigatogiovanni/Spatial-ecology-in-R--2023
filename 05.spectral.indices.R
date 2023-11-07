#vegetation indices

library(terra)
library(imageRy)
library()
library()

im.list()
#NASA Earth observatory -> you can search the file "matogrosso_ast_2006209_lrg.jpg" on thw website
#importing the file (matogrosso) #
m1992 <- im.import("matogrosso_l5_1992219_lrg.jpg") #earth resolution at 30 m
m2006 <- im.import("matogrosso_ast_2006209_lrg.jpg") 
#bands: 1 = NIR, 2 = RED , 3 = GREEN

#plotting with RGB
im.plotRGB(m1992, r = 1, g = 2, b = 3)
#or 
im.plotRGB(m1992, 1, 2, 3) #you can omit r = , g = and b =)
im.plotRGB(m1992, 2, 1, 3)

im.plotRGB(m2006, 2, 3, 1) #use the yellow to enlight something
