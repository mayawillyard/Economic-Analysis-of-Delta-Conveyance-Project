# Week 8 Notes second video
# Function writing 

# color can outline whats around it while fill will fill in the colors

# Learning Objectives: 
## Define a function that takes arguments
## Set default value for function arguments
## Explain why we should divide programs into small, single-purpose functions

read_csv
# what is happening in the read_csv functions 

## Defining a function -----------------------------------------------------
# arguments are the input, return values are the output
# for now, we will work with functions that return a single value
# writing out everything out in a ggplot is inconvenient 

# Process to write your own function --------------------------------------
## temperature conversion example: Farenheit to Kelvin
((50 - 32) * (5/9)) + 273.15
((62 - 32) * (5/9)) + 273.15
((72 - 32) * (5/9)) + 273.15

#Challenge
my_sum <- function(a,b){
  the_sum <- a + b
  return(the_sum)
}

my_sum # R spits out what codes are inside the name
my_sum( a=2, b=2)

sum <- my_sum( a=2, b=2)
sum

# provide default values for a function 
my_sum2 <- function(a = 1,b = 2){
  the_sum <- a + b
  return(the_sum)
}

my_sum2( b = 3)

## How do write function: 
# 1. Identify what piece(s) will change within your commands -- this is your argument
# 2. Remove it and replace with object(s) name(s)
# 3. Place code and argument into the function() function

((tempF - 32) * (5/9)) +273.15

f_to_k <- function(tempF){
  ((tempF - 32) * (5/9)) +273.15
}
#save the function as an object 
# put the defining code in what you want to change with; don't change the numbers that are fixed in the equation 
f_to_k
f_to_k(tempF = 72)


# generalization 

## Pass-by-value: changes or objects within the function only exist within the function
## what happens in the function, stays in the function

# set up function to iterate through multiple things 
# anything in the braces stays inside htere and does not go inside the global enviornment 

f_to_k <- function(tempF) {
  k <- ((tempF - 32) * (5/9)) +273.15
  return(k)
  print("hello")
} # the value is still showing as 295.3722

f_to_k(tempF = 72)
f_to_k(72)
# the return has to be in the second definition, in this case "k"
# passby values = only visible within the function and do not exist in the environment 
m <- f_to_k(72)
m

# m value isn't hello 
# best practice to include return function
# what is the difference between print vs return 
# return is a special call to put out this number 
# prints just purely prints and does not store it in the value 

class(m)
f_to_k <- function(tempF) {
  k <- data.frame (temp = ((tempF - 32) * (5/9)) +273.15)
  return(k)
}
n <- f_to_k(72)
n
farenheit <- f_to_k(tempF = 72)

# its own mini script within the script 
# return ends the function so you can only put it in the end of the function 
# you can't do it with print 

# sourceing function 

source("scripts/functions_practice.R")
# this doesn't run?? 

gapminder <- read_csv("https://ucd-r-davis.github.io/R-DAVIS/data/gapminder.csv")
gapminder %>% 
  filter(country == "Canada", year %in% c(1950:1970)) %>% 
  summarize(meanGDP = mean(gdpPercap, na.rm = TRUE))

# generalize this where we change country and year range 
avgGDP <- function(cntry,yr.range){
  df<- gapminder %>% 
  filter(country == cntry, year %in% yr.range) %>% 
  summarize(meanGDP = mean(gdpPercap, na.rm = TRUE))
  return(df)
  }
# yr. range in line 112 allows for you to run anything by line 114
# this function has two different data rangling tasks so pipes are being used 
# place holders go in the function calls 

avgGDP(cntry = "United States", yr.range = 1980:1995)

# this function lets you plug in anything you want because there is no hard wire!

# Challenge 
country_plot <- function(cntry) {
 d<-  gapminder %>% 
    select(country, year, pop) %>% 
    filter(country == cntry) %>% 
    ggplot(aes(x = year, y = pop)) +
    geom_point()
 return(d)
}

country_plot("Afghanistan")    
# if you put a hard wire value in that's the only variable that would come out 
