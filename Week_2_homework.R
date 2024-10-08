#Week 2 Homework 

set.seed(15) #set.seed is R producing random numbers
hw2 <- runif(50, 4, 50)
hw2 <- replace(hw2, c(4,12,22,27), NA)
#hw2_new <- na.omit (hw2) # na.omit is a function that handles missing values in objects
#this means that function will find all of the missing values in "hw2"
# R already knows what NA is a missing value so you ask R to find it by running the function
hw2[!is.na(hw2)]
hw2[!is.na(hw2)] [hw2[!is.na(hw2)]>= 14 & hw2[!is.na(hw2)]<= 38] #exclusion process of 14-38
prob1 <- hw2[!is.na(hw2)] [hw2[!is.na(hw2)]>= 14 & hw2[!is.na(hw2)]<= 38] 
prob1 #Question 1
times3 <- prob1 *3
times3 #Question 2
plus10 <- times3 + 10
plus10 #Question 2
plus10[c(TRUE,FALSE)] #Question 3
