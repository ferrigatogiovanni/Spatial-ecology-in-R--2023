# First lecture

# R as a calculator
2 + 3 

# Assign to an object
zima <- 2 + 3 #assigning with an operation
gio <- 23 #assigning directly a value
final <- zima * gio

#square of final
final^2

# creating an array and assign it to an object
sophi <- c(10, 20, 30, 50, 70) # microplastics # functions have parentheses and inside them there are arguments 
paula <- c(100, 500, 600, 1000, 2000) # people
plot(paula, sophi)
plot(paula, sophi, xlab = "number of people", ylab = "microplastics") #labelling the x and y axis

#overwriting an object
people <- paula
microplastics <- sophi

#modifyng the plot
plot(people, microplastics, pch = 19) #pch = typology of symbol
plot(people, microplastics, pch = 19, cex = 2) #cex = dimension of the symbol
plot(people, microplastics, pch = 19, cex = 2, col = "blue") #col = colour 
