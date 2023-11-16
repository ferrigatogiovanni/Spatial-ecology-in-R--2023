#External data

library(terra)

#setting working director -> setwd
#set the working directory based on the file path
#setwd("C:\Users\ferri\Documenti") -> this won't work, you have to change the direction of the slash
setwd("C:/Users/ferri/OneDrive/Documenti")

naja <- rast("najafiraq_etm_2003140_lrg")
plotRGB(naja, r = 1, g = 2, b = 3)
