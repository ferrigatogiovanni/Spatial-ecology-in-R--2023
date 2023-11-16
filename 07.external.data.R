#External data
#Earth Observatory (NASA): https://earthobservatory.nasa.gov/

library(terra)

#setting working director -> setwd
#set the working directory based on the file path
#setwd("C:\Users\ferri\Documenti") -> this won't work, you have to change the direction of the slash
setwd("C:/Users/ferri/OneDrive/Documenti")

naja <- rast("najafiraq_etm_2003140_lrg")
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
