# Vector Math 
##allows calculations on sets of numbers
x <- 1:10 #colon means sequence in order from 1-10
x 

x+3
x *10
x+ c(3)

y <- 100:109
y
x + y
#vectors are the same length so it is creating a pair
cbind (x,y,x, x+y)
z <- 1:2 #z is a different length than x as in there's only two numbers vs 10 numbers for x
z
x+z
cbind(x, z, x+ z)
# R starts recyling numbers/repeating numbers up until 10

#what is z is not an even number 
z <- 1:3
cbind(x,z,x+z) 
#warning message comes up because it is not a perfect multiple/resulting summation cuts off abruptly

a <- x+z

# you can also index a vector
x[c(TRUE, FALSE)] #choose every other value in x
x[c(TRUE, FALSE, FALSE)]
#recycling system used again