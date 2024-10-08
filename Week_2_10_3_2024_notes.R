#week 2 notes
## easiest thing to do in R is arithmetic 
###introduction to R:arithmetic 
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

which(myelephants == max(myelephants)) #what does this mean 


#project management 
#what is a working directory: location you are working from 
getwd() #tells you where you are working 
setwd() #inside paranthesis you specify directory
d <- read.csv(".data/tail_length.csv")

dir.create("./scripts")
#relative paths = pull data out of the folder 
# dir.create ("./video_notes")

#How R thinks about data - vector
#multiple values can equal one object

weight_g <- c(50,60,65,82)
animals <- c("ferret", "chincila", "otters")
animals

##inspections 
length(weight_g)
str(weight_g)


## change vectors
weight_g <- c(weight_g, 90) #without c R doesn't know how to combine values
weight_g

#Challenge
num_char <- c(1, 2, 3, "a")
num_logical <- c(1, 2, 3, TRUE)
char_logical <- c("a", "b", "c", TRUE)
tricky <- c(1, 2, 3, "4")
class(num_char)
class(num_logical)
class(char_logical)
class(tricky)
#you can't have two types of data in vectors (r goes to lowest common denominator)
#vectors have to be the SAME class of values
#coerces values to be all the same

#Subsetting
animal <- c("mouse", "rat", "dog", "cat")
animal[2]
animal[c(2,2)] #indexing take items from a vector and create a new combination of values

#chose values by certain criterias
weight_g <- c(21,34,39,54,55)
weight_g> 50
weight_g[weight>50]
#%in%
animal
animal %in% c("rat","cat","dog","duck","goat") #if its %in% orders don't have to be followed
animal == c("rat","cat","dog","duck","goat") #length means that chronology is checked
#ORDER MATTERS