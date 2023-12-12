#each pixel have its own level of refluectance
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

# building the final table
class <- c("forest", "human")
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
