# Data available at:
# https://land.copernicus.vgt.vito.be/PDF/portal/Application.html

library(ncdf4)
library(terra)

#setting the working directory
setwd("/Users/ferri/Downloads")

soilm <- rast("c_gls_SSM1km_202311250000_CEURO_S1CSAR_V1.2.1.nc")
plot(solim)
