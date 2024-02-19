####Analysis of the vegetation state in South Kalimantan (Borneo)
##this project focused on the South Kalimantan region in Borneo and the aim consisted in a multitemporal analysis of the
##vegetation state based on the changes over time of the following indexes: FCover and NDVI.

##first of all I must recall all the packages that I need for the analysis
library(ncdf4)     #to correctly import .nc files
library(terra)     #to use the crop and rast functions
library(raster)    #to work with raster files
library(viridis)   #inclusive color palette for color blind people
library(imageRy)   #to analyze images (im.classify())
library(ggplot2)   #to create appropriate graphs through the ggplot function
library(patchwork) #to add different bar plots together

##setting the working directory
setwd("C:/Users/ferri/OneDrive/Desktop/Spatial ecology project")

####Analysis of FCOVER over time 

##importing the downloaded data

##the data was downloaded from Copernicus and it's about the FCOVER (Fraction of 
##Green Vegetation Cover)
fcover1999 <- rast("c_gls_FCOVER_199901100000_GLOBE_VGT_V2.0.2.nc")
fcover2007 <- rast("c_gls_FCOVER_200701100000_GLOBE_VGT_V2.0.1.nc")
fcover2014 <- rast("c_gls_FCOVER-RT6_201401100000_GLOBE_PROBAV_V2.0.2.nc")
fcover2020 <- rast("c_gls_FCOVER-RT6_202001100000_GLOBE_PROBAV_V2.0.1.nc")

##I'm going to use a color palette visible to everyone
cl <- colorRampPalette(viridis(7))(255) 

##there are many images but since I'm not using all of them I'm just selecting 
##the ones that I need 
par(mfrow = c(2,2))
plot(fcover1999[[1]], col = cl)
plot(fcover2007[[1]], col = cl)
plot(fcover2014[[1]], col = cl)
plot(fcover2020[[1]], col = cl)
dev.off()

##These images refer to all the world and since I want to focus on the South 
##Kalimantan region in Borneo, I need to crop the images 
##setting the limits of the cropping
lat_min = -4.2136  #minimum longitude
lat_max = -1.1737  #maximum longitude
lon_min = 114.0199 #minimum latitude
lon_max = 116.6126 #maximum latitude
ext <- c(lon_min, lon_max, lat_min, lat_max)

##cropping the images with the limits that I've just decided
fcover1999_crop <- crop(fcover1999[[1]], ext)
fcover2007_crop <- crop(fcover2007[[1]], ext)
fcover2014_crop <- crop(fcover2014[[1]], ext)
fcover2020_crop <- crop(fcover2020[[1]], ext)

##to better visualize and manipulate the data I'm gonna stack the images just cropped 
fcover_stack <- c(fcover1999_crop, fcover2007_crop, fcover2014_crop, fcover2020_crop)

##visualizing the images 
plot(fcover_stack,main = c("FCover in 1999", "FCover in 2007", "FCover in 2014",
                           "FCover in 2020"), col = cl)
dev.off()

##now I want to observe the difference of FCOVER between the periods considered
diff_fcov99_07 <- fcover_stack[[1]] - fcover_stack[[2]]
diff_fcov07_14 <- fcover_stack[[2]] - fcover_stack[[3]]
diff_fcov14_20 <- fcover_stack[[3]] - fcover_stack[[4]]
diff_fcov99_20 <- fcover_stack[[1]] - fcover_stack[[4]]

##plotting the differences 
par(mfrow = c(2,2))
plot(diff_fcov99_07, main = "Changes between 1999 and 2007", col = cl)
plot(diff_fcov07_14, main = "Changes between 2007 and 2014", col = cl)
plot(diff_fcov14_20, main = "Changes between 2014 and 2020", col = cl)
plot(diff_fcov99_20, main = "Changes between 1999 and 2020", col = cl)
dev.off()

##since I want to highlight better the difference I'm gonna classify the graphic of the changes between 1999 and 2007, 
##which is the whole period considered in this analysis
##the classification is going to be in three different categories/classes:
##increase in fcover, no change in fcover, decrease in fcover
##observe the change in pixels
diff_fcov99_20c <- im.classify(diff_fcov99_20, num_clusters = 3, colors = c("white", "yellow2", "chartreuse3"))

##plotting the difference in pixels
plot(diff_fcov99_20c)
dev.off()

##calculating the total number of pixels in the image
total_pixel <- ncell(diff_fcov99_20c)

#computing the percentage of each class (frequency of each class * 100)
(freq(diff_fcov99_20c)/total_pixel)*100

##the results are:
##(freq(diff_fcov99_20c)/total_pixel)*100
##layer       value     count
##1 0.001014199 0.001014199  8.942191
##2 0.001014199 0.002028398 78.008114
##3 0.001014199 0.003042596 13.049696

##creating the results table
classes_fc <- c("Increase in fcover", "No change in fcover", "Decrease in fcover")
freq_chg_99_20 <- c(8.94, 78.01, 13.05)

##putting classes_fc and freq_chg_99_20 together
results <- data.frame(classes_fc, freq_chg_99_20)

##creating the gglplot
p99_20 <- ggplot(results, aes(x = classes_fc, y = freq_chg_99_20)) + 
          geom_bar(stat = "identity", fill = c("white", "yellow2", "chartreuse3")) +
          geom_text(aes(label = freq_chg_99_20), size = 5, hjust = 0.5, vjust = 0, 
          position = "stack") + ylim(c(0,100))
p99_20
dev.off()

####computing the NDVI

##now I want to focus on a determined area within the region and observe the 
##differences from 2018 to 2023

##first I must import the images that I downloaded from Sentinel-2; these images are in 
##false color, with bands 8 (NIR band), 4 (red band) and 3 (green band)
SK2018 <- rast("2018-09-23-00_00_2018-09-23-23_59_Sentinel-2_L2A_False_color.jpg")
SK2023 <- rast("2023-09-27-00_00_2023-09-27-23_59_Sentinel-2_L2A_False_color.jpg")

##first look at the images
par(mfrow = c(2,1))
plotRGB(SK2018,1,2,3)
plotRGB(SK2023,1,2,3)
dev.off()

##calculating the DVI (Difference Vegetation Index)
##DVI = NIR - RED
##I know that bands: 1 = NIR, 2 = RED, 3 = GREEN
dvi2018 <- SK2018[[1]]-SK2018[[2]]
plot(dvi2018, col = cl, main = "DVI 2018")
dvi2023 <- SK2023[[1]]-SK2023[[2]]
plot(dvi2023, col = cl, main = "DVI 2023")

##calculating the NDVI (Normalized Difference Vegetation Index)
ndvi2018 <- dvi2018/(SK2018[[1]]+SK2018[[2]]) #or ndvi2018 <- im.ndvi(SK2018, 1, 2)
plot(ndvi2018, col = cl, main = "NDVI 2018")
ndvi2023 <- dvi2023/(SK2023[[1]]+SK2023[[2]]) #or ndvi2023 <- im.ndvi(SK2023, 1, 2)
plot(ndvi2023, col = cl, main = "NDVI 2023")

##plotting ndvi2018 and ndvi2023 toghether
par(mfrow = c(2,1))
plot(ndvi2018, col = cl, main = "NDVI 2018")
plot(ndvi2023, col = cl, main = "NDVI 2023")
dev.off()

##calculating the difference between the two years
ndvi_dif <- ndvi2018 - ndvi2023
plot(ndvi_dif, col=cl)
dev.off()

##classification over time 
##classifying the images 
SK2018c <- im.classify(SK2018, num_clusters = 2) #two clusters because there aren't any clouds
SK2023c <- im.classify(SK2023, num_clusters = 3) #in the 2023 image there are clouds that cover the ground so I need to consider it

##plotting the images together
class_sk <- c("Forest", "No Forest", "Data not available (Clouds)")
par(mfrow = c(2,1))
plot(SK2018c[[1]], main = "Classes from 2018", type = "classes", levels = class_sk, col = cl)
plot(SK2023c[[1]], main = "Classes from 2023", type = "classes", levels = class_sk, col = cl)
dev.off()

##finding the total number of pixels in the pictures
tot_pixel2018 <- ncell(SK2018c)
tot_pixel2023 <- ncell(SK2023c)

##finding the percentage
(freq(SK2018c[[1]])/tot_pixel2018)*100
(freq(SK2023c[[1]])/tot_pixel2023)*100

##(freq(SK2018c[[1]])/tot_pixel2018)*100
##layer        value    count
##1 7.226739e-05 7.226739e-05 73.59834
##2 7.226739e-05 1.445348e-04 26.40166

##(freq(SK2023c[[1]])/tot_pixel2023)*100
##layer        value     count
##1 7.226739e-05 7.226739e-05 74.051093
##2 7.226739e-05 1.445348e-04  4.743487
##3 7.226739e-05 2.168022e-04 21.205420

##building the final table
class_sk <- c("Forest", "No Forest", "Data not available (Clouds)")
percentages_2018 <- c(73.6, 26.4, 0)
percentages_2023 <- c(74.1, 21.2, 4.7)

##putting all together in a data frame
chg_sk <- data.frame(class_sk, percentages_2018, percentages_2023)
chg_sk

#final output
g2018 <- ggplot(chg_sk, aes(x = class_sk, y = percentages_2018, color = class_sk)) + 
                geom_bar(stat="identity", fill="white") + xlab("Classes") + ylab("Values") +
                ggtitle("Vegetation Cover in 2018") + ylim(c(0,100))
g2018
g2023 <- ggplot(chg_sk, aes(x = class_sk, y = percentages_2023, color = class_sk)) + 
                geom_bar(stat="identity", fill="white") + xlab("Classes") + ylab("Values") +
                ggtitle("Vegetation Cover in 2023") + ylim(c(0,100))
g2023

##adding the two bar plots together
g2018 + g2023

##### In order to find more evidence in support of what I just found with NDVI 
##and classification results, I'm gonna follow a moving window approach for a 
##further diversity assessment by using the focal() function

##calculating the sd in a 3x3 matrix with nir band SK2018[[1]] and SK2023[[1]]
##standard deviation for 2018
sd3_2018 <- focal(SK2018[[1]], matrix(1/9,3,3), fun = sd)
plot(sd3_2018, col = cl, main = "NIR band from 2018", cex.main = .8) 
dev.off()

#standard deviation for 2023
sd3_2023 <- focal(SK2023[[1]], matrix(1/9,3,3), fun = sd)
plot(sd3_2023, col = cl, main = "NIR band from 2023", cex.main = .8) 
dev.off()

##plotting the results together
par(mfrow=c(1,2))
plot(sd3_2018, main = "NIR band from 2023", cex.main = .8) 
plot(sd3_2023, main = "NIR band from 2023", cex.main = .8) 
dev.off()

##plotting the results together (viridis colour)
par(mfrow=c(1,2))
plot(sd3_2018, col = cl, main = "NIR band from 2018", cex.main = .8) 
plot(sd3_2023, col = cl, main = "NIR band from 2023", cex.main = .8) 

##the study area remained quite unchanged over time (as I found with the NDVI and
##classification analysis computed before)
