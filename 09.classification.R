#each pixel have its own level of refluectance
#you can calculate the distances between the reflectances and assign a class (e.g. water,urban area, mountain) to each pixel based on the reflactance 

# Classifying satellite images and estimates the amount of change

library(terra)
library(imageRy)

im.list()

#importing the sun image
sun <- im.import("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg")
