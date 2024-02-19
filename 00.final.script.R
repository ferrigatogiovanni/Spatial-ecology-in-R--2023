# Final script including all different scripts during lectures 

#----------------------------

# Summary:
# 01 Beginning
# 02.1 Population density
# 02.2 Population distribution
# 03.1 Community multivariate analysis 
# 03.2 Community overlap
# 04 Remote sensing data visualization
# 05 Spectral indices
# 06 Time series
# 07 External data
# 08 Copernicus data
# 09 Classification
# 10 Variability
# 11 Principal Component Analysis

#----------------------------

# 01 Beginning

## First lecture

# R as a calculator
2 + 3 

# Assign to an object
zima <- 2 + 3 #assigning with an operation
gio <- 23 #assigning directly a value
final <- zima * gio

#square of final
final^2

# creating an array and assign it to an object
sophi <- c(10, 20, 30, 50, 70) # microplastics # functions have parentheses and inside them there are arguments 
paula <- c(100, 500, 600, 1000, 2000) # people
plot(paula, sophi)
plot(paula, sophi, xlab = "number of people", ylab = "microplastics") #labelling the x and y axis

#overwriting an object
people <- paula
microplastics <- sophi

#modifyng the plot
plot(people, microplastics, pch = 19) #pch = typology of symbol
plot(people, microplastics, pch = 19, cex = 2) #cex = dimension of the symbol
plot(people, microplastics, pch = 19, cex = 2, col = "blue") #col = colour 

#----------------------------

# 02.1 Population density

# code related to population ecology

# how to install a code
# a code is needed for point pattern analysis
install.packages("spatstat")

# how to check if a code has been correctly installed
library(spatstat)

# let's use the bei data (dataset) (trees in the tropical area forests)
bei

# plotting the data
plot(bei)

# changing the dimension - cex
plot(bei, cex = 0.5)

# changing the symbols - pch (there are many types)
plot(bei, cex = 0.5, pch = 19)

# additional datasets
bei.extra
plot(bei.extra)

# let's use only a part of the dataset: elev ($ is linking elev with bei.extra)
plot(bei.extra$elev)
elevation <- bei.extra$elev   #creating an object called elevation
plot(elevation)
bei.extra

# second method to select elements
elevation2 <- bei.extra[[1]] #it's the same as we did before (bei.extra$elev)
plot(elevation2)

# passing from points to a continuous surface
densitymap <- density(bei) #now dealing with pixels
plot(densitymap)
points(bei, cex = .2) #how to add a plot to the current one without erasing the first

# how to change color to the plot (package -> see viridis color maps on IT)
c1 <- colorRampPalette(c("black", "red", "orange", "yellow"))(100)
plot(densitymap, col = c1)
c2 <- colorRampPalette(c("cornflowerblue","cyan","blue","darkorchid"))
plot(densitymap, col = c2)  

plot(bei.extra)
elev <- bei.extra[[1]] # or you can use bei.extra$elev
plot(elev) # you are plotting the elevation of the area 

# multiframe 
par(mfrow = c(1,2)) # we are putting two plots next to each other (1 row, 2 columns)
plot(densitymap)
plot(elev)

par(mfrow = c(2,1)) # we are putting the second plot under the first one (2 row, 1 columns)
plot(densitymap)
plot(elev) 

par(mfrow = c(1,3))
plot(bei)
plot(densitymap)
plot(elev)  # we can observe that the higher elevation corresponds to the lower density

#----------------------------

# 02.2 Population distribution

# why pupulations disperse over the landscape in a certain number?
# (GDAL -> https://gdal.org/index.html, GDAL is now inside the package TERRA) 

library(sdm)
library(terra)

system.file("external/species.shp", package="sdm") #importing the file species that is located inside the package sdm
file <- system.file("external/species.shp", package="sdm") 
file #returns the location of the file (species)

# looking at the set
species <- vect(file) #in this file there are vectors 

# looking at the occurrences
specie$Occurence # how to see the presences of the specie (1 present, 0 absent)

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

# putting two plots near each others
par(mfrow = c(1,2))
plot(pres)
plot(abse)

# it erases the previous plots/graphics
dev.off()

# plotting presences and absences altogether
plot(pres)
points(abse, col = "blue")

# how to check the path
path <- system.file("external", package="sdm") 

# predictors: environmental variables
# elevation predictor 
elev <- system.file("external/elevation.asc", package="sdm")
elev
elevmap <- rast(elev)    #from Terra package (rast are images)
plot(elevmap)
points(pres, cex = .5) #adding the presences 

# temperature predictor
temp <- system.file("external/temperature.asc", package="sdm")
temp #it shows the path to the file temperature
tempmap <- rast(temp)
plot(tempmap)
points(pres, cex = .5)

# vegetation predictor
vege <- system.file("external/vegetation.asc", package="sdm")
vegemap <- rast(vege)
plot(vegemap)
points(pres, cex = .5)

# precipitation predictor
prec <- system.file("external/precipitation.asc", package="sdm")
precmap <- rast(prec)
plot(precmap)
points(pres, cex = .5)

# final multiframe 
par(mfrow = c(2,2))

plot(elevmap) #elevation
points(pres, cex = .5)

plot(tempmap) #temperature
points(pres, cex = .5)

plot(vegemap) #vegetation
points(pres, cex = .5)

plot(precmap) #precipitation
points(pres, cex = .5)

#----------------------------

# 03.1 Community multivariate analysis 

#https://cran.r-project.org/web/packages/vegan/vegan.pdf
library(vegan)

data(dune) #see data() function
dune
head(dune) #just to see the first 6 rows of the data

ord <- decorana(dune) #see Detrended correspondence analysis (DCA)
?decorana
ord

#we want to measure the length of the axis
ldc1 <- 3.7004 #length of DC1
ldc2 <- 3.1166 
ldc3 <- 1.30055 
ldc4 <- 1.47888

#total length
total = ldc1 + ldc2 + ldc3 + ldc4

#calculating the percentage on the total for each ldc
pldc1 = ldc1 * 100 / total
pldc2 = ldc2 * 100 / total
pldc3 = ldc3 * 100 / total
pldc4 = ldc4 * 100 / total

pldc1; pldc2 
pldc1 + pldc2 #summing the first 2 to find the lenth of the axis

plot(ord)
#see bromus hordeaceus (Bromhord in the plot)
#on the other side: salix repens (Salirepe in the plot)
#from the plot you can see the different plants (based on the position in the plot)

#----------------------------

# 03.2 Community overlap

# overlap package -> https://cran.r-project.org/web/packages/overlap/overlap.pdf

#relation among species in time
library(overlap)
?overlap

#data
data(kerinci)
kerinci #you can see all the data
head(kerinci) #just the first 6 rows
summary(kerinci)

#tiger
tiger <- kerinci[kerinci$Sps == "tiger", ] #selecting the data related only to tigers
tiger
summary(tiger)

# calculating the time in radiance (time = time in the day in which was spotted the animal)
kerinci$timeRad <- kerinci$Time * 2 * pi #adding a new column with the time in radiance

#
tiger <- kerinci[kerinci$Sps == "tiger", ] #overwriting tiger 

#plotting only timeRad of tiger
plot(tiger$timeRad)

timetig <- tiger$timeRad
densityPlot(timetig, rug = 2) #rug is used to smooth the lines
?densityPlot

#exercise: select only the data on the macaque
macaque <- kerinci[kerinci$Sps == "macaque", ]
summary(macaque)
head(macaque)

#plotting timeRad of the macaque
timemac <- macaque$timeRad
densityPlot(timemac, rug = TRUE)

#overlapping timetig and timemac
?overlapPlot
overlapPlot(timetig, timemac)
#the plot enlights the time of the day in which is more probable to find the two animals together

#----------------------------

# 04 Remote sensing data visualization

#remote sensing for ecosystem monitoring
#(remote sensing in ecology and conservation -> see website)
# RS data

library(devtools) #you need it in order to use install_github
library(terra)

#install_github("ducciorocchini/imageRy") --> https://www.rdocumentation.org/packages/devtools/versions/1.13.6/topics/install_github
library(imageRy) #recall the package

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
#blue color ramp
clblue <- colorRampPalette(c("dark blue","blue","light blue")) (100)
plot(b2, col = clblue)

#green color ramp
clgreen <- colorRampPalette(c("dark green","green","light green")) (100)
plot(b3, col = clgreen)

#red color ramp
clred <- colorRampPalette(c("dark red","red","pink")) (100)
plot(b4, col = clred)

clnir <- colorRampPalette(c("brown","orange","yellow")) (100)
plot(b2, col = clnir)

#plotting all together
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

#----------------------------

# 05 Spectral indices

#vegetation indices

library(terra)
library(imageRy)

im.list()
#NASA Earth observatory -> you can search the file "matogrosso_ast_2006209_lrg.jpg" on thw website
#importing the file (matogrosso) 
m1992 <- im.import("matogrosso_l5_1992219_lrg.jpg") #earth resolution at 30 m
m2006 <- im.import("matogrosso_ast_2006209_lrg.jpg") 
#we know that bands are: 1 = NIR, 2 = RED , 3 = GREEN this are the common bands or, otherwise, is noted in the meta-data

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

#Difference vegetation index (DVI)-> DVI = NIR - RED; DVI is always ranging from -255 to 256 
#(bands: 1 = NIR, 2 = RED , 3 = GREEN)
#calculating DVI of 1992
dvi1992 = m1992[[1]]-m1992[[2]]
plot(dvi1992) #the values under 0 (on the right) are barren soils or suffering plants (negative reflectace)
c1 <- colorRampPalette(c("dark blue", "yellow", "red", "black"))(100)
plot(dvi1992, col = c1) #the darkest colour represent the healthier part of the forest
#calculating DVI of 2006
dvi2006 = m2006[[1]]-m2006[[2]]
plot(dvi2006, col = c1) #the healthier vegetation is not high and expanded as before

#Normalized difference vegetation index (NDVI) -> NDVI is always ranging from -1 to 1 
#calculating NDVI of 1992
ndvi1992 = (m1992[[1]] - m1992[[2]]) / (m1992[[1]] + m1992[[2]])
#or
ndvi1992 = dvi1992 / (m1992[[1]] + m1992[[2]])
plot(ndvi1992, col = c1) #you can see the range on the right (-1 -> 1)
#calculating NDVI of 2006
ndvi2006 = dvi2006 / (m2006[[1]] + m2006[[2]])
plot(ndvi2006, col = c1)

#plotting ndvi1992 and ndvi2006 toghether
par(mfrow = c(1,2))
plot(ndvi1992, col = c1)
plot(ndvi2006, col = c1)

#speeding up calculations
ndvi2006a <- im.ndvi(m2006, 1, 2) #ypu can use the function im.ndvi instead of writing calculations
plot(ndvi2006a, col = cl)

#----------------------------

# 06 Time series

# time series analysis

library(imageRy)
library(terra)

im.list()

# import the data
EN01 <- im.import("EN_01.png")
EN13 <- im.import("EN_13.png")

par(mfrow=c(2,1))
im.plotRGB.auto(EN01)
im.plotRGB.auto(EN13)

# using the first element (band) of images
dif = EN01[[1]] - EN13[[1]] #[[1]] -> selecting the first element

# palette
cldif <- colorRampPalette(c("blue", "white", "red")) (100)
plot(dif, col=cldif)
# red is higher in march, yellow is higher in january
# so we have a huge decrease in march (there's more yellow than red)
# we see that in many cities people stopped to use cars

########
### New example: temperature in Greenland
########

g2000 <- im.import("greenland.2000.tif")
clg <- colorRampPalette(c("black", "blue", "white", "red")) (100)
plot(g2000, col=clg)

g2005 <- im.import("greenland.2005.tif")
g2010 <- im.import("greenland.2010.tif")
g2015 <- im.import("greenland.2015.tif")

plot(g2015, col=clg)

#observing the changes from 2000 to 2015
par(mfrow=c(1,2))
plot(g2000, col=clg)
plot(g2015, col=clg)

# stacking the data
stackg <- c(g2000, g2005, g2010, g2015)
plot(stackg, col=clg)
# we see that the surface temperature in Greenland have increased and then decreased back, while that in the Nunavut has gradually increased
# also Island's temperature has decreased a little bit

# Exercise: make the differencxe between the first and the final elemnts of the stack
difg <- stackg[[1]] - stackg[[4]]
# difg <- g2000 - g2015
plot(difg, col=cldif)

# Exercise: make a RGB plot using different years
im.plotRGB(stackg, r=1, g=2, b=3)

#----------------------------

# 07 External data

#External data
#Earth Observatory (NASA): https://earthobservatory.nasa.gov/

library(terra)

#setting working director -> setwd
#set the working directory based on the file path
#setwd("C:\Users\ferri\Documenti") -> this won't work, you have to change the direction of the slash
setwd("C:/Users/ferri/OneDrive/Documenti")

#importing the data
naja <- rast("najafiraq_etm_2003140_lrg")

#plotting naja with plotRGB()
plotRGB(naja, r = 1, g = 2, b = 3)

#Exercise: Download the second image from the same site and import it in R
najaaug <- rast("najafiraq_oli_2023219_lrg.jpg")
plotRGB(najaaug, r = 1, g = 2, b = 3)

par(mfrow = c(2,1))
plotRGB(naja, r = 1, g = 2, b = 3) #in the exam you can download 2 images and show the changes by putting them near each other
plotRGB(najaaug, r = 1, g = 2, b = 3)

#multitemporal change detection
najadif = naja[[1]] - najaaug[[1]]
cl <- colorRampPalette(c("brown", "grey", "orange"))(100)
plot(najadif, col = cl)

#Adding another image (https://earthobservatory.nasa.gov/images/151802/summer-rains-on-nevadas-black-rock-playa)
nevada_flooding <- rast("nevada_flooding_oli2_2023247_lrg.jpg")
plotRGB(nevada_flooding, r = 1, g = 2, b = 3)

#The Mato Grosso images (used in the previous lessons) can be downloaded directly from EO-NASA (just search Mato Grosso on Earth Observatory and download the images): 
#https://earthobservatory.nasa.gov/images/35891/deforestation-in-mato-grosso-brazil
mato <- rast("matogrosso_l5_1992219_lrg.jpg")
plotRGB(mato, r=1, g=2, b=3)

#For the exam you can take the data from the sources listed in the code "07.external.data.import.R" on the professor's GitHub

#----------------------------

# 08 Copernicus data

# Data available at:
# https://land.copernicus.vgt.vito.be/PDF/portal/Application.html

library(ncdf4) #you need this in order to use the function rast
library(terra)

#setting the working directory
setwd("/Users/ferri/Downloads")

#importing the data (using the function rast) by indicating the file that I want to use
soilm <- rast("c_gls_SSM1km_202311250000_CEURO_S1CSAR_V1.2.1.nc")

plot(soilm) 
#there are 2 elements, we just need the first one (the second one is ssm_noise -> indicate the errors)
plot(soilm[[1]])

cl <- colorRampPalette(c("red", "orange", "yellow"))(100)
plot(soilm[[1]], col = cl)

#cropping the graphic usig the function crop
#setting the limits of the cropping
ext <- c(22, 26, 55, 57) #(minimum longitude, maximum longitude, minimum latitude, maximum latitude)
#cropping the graphic with "ext" limits and putting the new graphic into a new variable called "soilmcrop"
soilmcrop <- crop(soilm[[1]], ext)
#plotting the cropped graphic
plot(soilmcrop, col = cl)

#another example
ext <- c(-180, 180, -90, 90) #(minimum longitude, maximum longitude, minimum latitude, maximum latitude)
extension <- crop(s, ext)

##### CROP FUNCTION -> IMPORTANT FOR THE EXAM IF YOU WANT TO FOCUS YOUR ANALYSIS ON A SPECIFIC AREA OF THE GRAPHIC (example -> specific lake in Africa)

#----------------------------

# 09 Classification

# Estimate the qualitative and quantitative difference between two images taken at different times
# We need to transform images in classes (land cover, land use, etc.)
#each pixel have its own level of reflectance
#you can calculate the distances between the reflectances and assign a class (e.g. water,urban area, mountain) to each pixel based on the reflactance 

# Classifying satellite images and estimates the amount of change

library(terra)
library(imageRy)
library(ggplot2)
library(patchwork)

im.list()

#importing the sun image from imageRy
sun <- im.import("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg") #(yellow corresponds to higher energy and black corresponds to low energy)

#classifying the image sun just imported
sunc <- im.classify(sun, num_clusters = 3) #when you use im.classify() the classes may differ from one pc to another so we have to check and comment what each class is representing

plot(sunc)
#how can I know which class has the highest energy in sunc?
plot(sun) #(yellow corresponds to higher energy and black corresponds to low energy)
plot(sunc)
#just plot the two and see where the colours overlaps; in my case class 2 (yellow) corresponds to the higher energy and class 3 (green) correrponds to the lower energy 
#(class 1 - white - corresponds to an intermediate level of energy)

# Classify satellite data
im.list()
#importing the images (images of the same place after years)
m1992 <- im.import("matogrosso_l5_1992219_lrg.jpg") #red is vegetation; water should be black but in this case there are deposits so it's difficult to see the difference
m2006 <- im.import("matogrosso_ast_2006209_lrg.jpg") 

m1992c <- im.classify(m1992, num_clusters = 2) #forest is class number 2 and human is class 1 -> classes: forest = 2; human = 1
plot(m1992c)
m2006c <- im.classify(m2006, num_clusters = 2) #classes: forest = 1; human = 2 (same as m1992c in this case)
plot(m2006c)

par(mfrow = c(1,2))
plot(m1992c)
plot(m2006c)
#if you have 3 equal plots do this 
par(mfrow = c(1,2))
plot(m1992c[[1]])
plot(m2006c[[1]])

#how many pixels are in each image
f1992 <- freq(m1992c) #for each layes
f1992
tot1992 <- ncell(m1992c) #total pixels
tot1992
#percentage
p1992 <- f1992 * 100 / tot1992
p1992 #forest: 83%; human: 17%

f2006 <- freq(m2006c) #for each layes
f2006
tot2006 <- ncell(m2006c) #total pixels
tot2006
#percentage
p2006 <- f2006 * 100 / tot2006
p2006 #forest: 45%; human: 55%

# Building the final table, which means a graph with all this data -> function: data
# We need to build the columns class <- c("forest", "human")
y1992 <- c(83, 17)
y2006 <- c(45, 55)

tabout <- data.frame(class, y1992, y2006)
tabout

#final output 
p1 <- ggplot(tabout, aes(x=class, y=y1992, color=class)) + geom_bar(stat="identity", fill="white") #expressing 1992 data in a barplot
p1
p2 <- ggplot(tabout, aes(x=class, y=y2006, color=class)) + geom_bar(stat="identity", fill="white") #expressing 2006 data in a barplot
p2
#in order to add them you need library(patchwork)
p1 + p2 #adding the two barplots

# final output, rescaled
p1 <- ggplot(tabout, aes(x=class, y=y1992, color=class)) + geom_bar(stat="identity", fill="white") + ylim(c(0,100)) #ylim -> adding units pn the side of the barplot
p2 <- ggplot(tabout, aes(x=class, y=y2006, color=class)) + geom_bar(stat="identity", fill="white") + ylim(c(0,100))
p1 + p2

#----------------------------

# 10 Variability

# measurement of RS based variability
# there are different indices in statistics: the most simple thing in our case was to measure the standard deviation, that is how much the different data are divergin from the mean
# we measured it with the focal() function

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

# moving window approach for divesity assessment
# we are going to calculate the standard deviation (sd) of windows of pixels, one at the time
# in the end we would have passed the window in the whole image, calculating each time the sd 
# value of the central pixel of the window
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

#----------------------------

# 11 Principal Component Analysis

# PCA -> Principal Component Analysis

library(imageRY)
library(terra)
library(viridis)

im.list()

sent <- im.import("sentinel.png")

pairs(sent) #3rd row, 2nd column -> high correlation

# MULTIVARIATE ANALYSIS
# Measurement of R based variability with a single layer, which is chosen objectively with Multivariate Analysis
# compact the 3 bands of sentinel into one to better visualize it

#perform PCA on sent
sentpc <- im.pca2(sent)
sentpc

# it says that the principal component will show the 71% of the variability, the second 53% and so on

pc1 <-sentpc$PC1 #selecting just the first image
viridisc <- colorRampPalette(viridis(7))(255)
plot(pc1, col=viridisc)

#Calculating standard deviation ontop of pc1 in a 3x3 matrix
pc1sd3 <- focal(pc1, matrix(1/9, 3, 3), fun=sd)
plot(pc1sd3, col=viridisc)

#Calculating standard deviation ontop of pc1 in a 3x3 matrix
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

#----------------------------
