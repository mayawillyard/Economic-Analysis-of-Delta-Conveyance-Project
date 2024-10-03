#how r thinks about data - vectors
#understand differnt data types and vector types
#vectors are any series of value 

weight <- c( 50, 73, 47, 2)
weight

## vector with texts
animals <- c("mouse", "horse", "rat") #always quote words
animals
# quotes tell r that it is a character






### additional functions
class(weight) ##different classes are shown in this example
class(animals)
length(weight)
length(animals)

#str is structure
str(weight)
#when do you use a structure

## how to change vector
weight <- c(weight, 90) #adds to the end of the vector
weight

weight <- c(3, weight) 
weight
