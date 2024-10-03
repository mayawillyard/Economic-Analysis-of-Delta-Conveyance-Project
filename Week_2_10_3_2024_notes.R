#week 2 notes
## easiest thing to do in R is arithmetic 
#introduction to R:arithmetic 
3+4

2*
## + sign means R is waiting for you to finish the code

  
  4+8*3^2
2/100000

#mathematical functions 
sqrt(4)

#r help files
?log
log(2,4)
log(4,2)
log(x=2,base=4)
#if argument is specified no need to follow orders

#nested functions
sqrt(exp(4))

#six comparison functions 
mynumber <- 6
mynumber == 5

# != not 
mynumber != 5

#errors and warnings
log_of_word <- log("a_word")
log_of_word  #error means does not exist in R
#copy and run big chunks of code 
#warnings are more dangerous than errors
elephant1_kg <- 3492
elephant2_lb <- 7757

elephant1_kg <- elephant2_lb *2.2

elephant2_lb> elephant1_lb

myelephants <- c(elephant1_lb,elephant2_lb)

which(myelephants == max(myelephants)) #
