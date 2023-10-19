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
