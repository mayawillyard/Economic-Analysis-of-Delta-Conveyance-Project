#Missing Data
NA #special character
NaN #notnumber

"NA" #R will see this as a text or missing value

heights <- c(2,4,4,NA,6)

mean(heights)
max(heights)
sum(heights)
mean(heights, na.rm = TRUE)
mean(heights, na.rm = T) #same meaning

is.na(heights)
#the answer to this is written in same sequence as input data
!is.na(heights) #gives exact opposite values from original function 

heights[!is.na(heights)] #values without the na shows up USE THIS FOR WEEK 2 HMK

#complete cases = returns an object that has only values where there is full information available
heights[complete.cases(heights)] #removes NA
