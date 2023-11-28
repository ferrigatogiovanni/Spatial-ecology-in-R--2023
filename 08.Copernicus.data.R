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
#cropping the graphic with ext limits and creating a new variable called soilmcrop
soilmcrop <- crop(soilm[[1]], ext)
#plotting the cropped graphic
plot(soilmcrop, col = cl)

#another example
ext <- c(-180, 180, -90, 90) #(minimum longitude, maximum longitude, minimum latitude, maximum latitude)
extension <- crop(s, ext)
