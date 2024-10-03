#subsetting 
animals <- c("mouse", "rat", "dog", "cat")
animals[2] #only want to extract second value

animals [c(2,3)]


animals [c(2,3,2,3,2,3)]


#conditional subsetting - logical vector subsetting
weight <- c(14,76,81,25,46)
weight[c(TRUE,TRUE,FALSE,FALSE,FALSE)] #false stops specified values from appearing
weight [weight>50 ] #only weight over 50 shows up
weight > 50 #output of logical values comes out in console

#mulitple tests
weight[weight>50|weight<20] # the absolute value represents OR
#use amper sand to represent and 
# AND --> &
# other symbols  
weight[weight>=46]
 