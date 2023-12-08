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


