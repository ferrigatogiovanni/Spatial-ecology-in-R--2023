#each pixel have its own level of refluectance
#you can calculate the distances between the reflectances and assign a class (e.g. water,urban area, mountain) to each pixel based on the reflactance 

# Classifying satellite images and estimates the amount of change

library(terra)
library(imageRy)

im.list()

#importing the sun image from imageRy
sun <- im.import("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg") #(yellow corresponds to higher energy and black corresponds to low energy)

#classifying the image sun just imported
sunc <- im.classify(sun, num_clusters = 3) 

plot(sunc)
#how can I know which class has the highest energy in sunc?
plot(sun) #(yellow corresponds to higher energy and black corresponds to low energy)
plot(sunc)
#just plot the two and see where the colours overlaps; in my case class 2 (yellow) corresponds to the higher energy and class 3 (green) correrponds to the lower energy 
#(class 1 - white - corresponds to an intermediate level of energy)
