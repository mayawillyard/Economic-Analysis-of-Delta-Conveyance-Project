#Data Manipulation Video Notes Part 1a Selecting, filtering, and piping
# "dplyr" is good for data table manipulation
# tidyr helps switch between data formats
# benefits of tidyverse: predictable results, syntax is straightforward, avoids default arguments

library(tidyverse)
surveys <- read_csv("data/portal_data_joined.csv")
#in order to open surveys, either click on it directly from environment OR type view(surveys) on console
str(surveys) #Survey results shown in console and won't take too much space/more readable

# Practice selecting columns 
# month_day_year <- select (surveys, month, day, year)
# first varaiable in paranethesis is the data file, then, list every single column you want to KEEP
month_day_year <- select (surveys, month, day, year)

#filter by equals 
# use to filter out specific rows that meet certain criteria
filter (surveys, year== 1981) # logical condition: KEEP entries that have the year 1981
#no new varaiable in environment from FILTER function 
#didn't assign new variable but just ran it HOWEVER if you assign it like below, then shows up in env.
year_1981 <- filter (surveys, year== 1981)
#Can't name a variable starting with a number 

#Filtering out MULTIPLE years/BY RANGE
filter (surveys, year %in% c(1981:1983))
# %in% is the BUCKET search so out of all of the observation find everything with 1981,1982,1983


#REVIEW: NEVER LIST
filter (surveys, year== c(1981,1982,1983)) #INDEX LEVEL MATCHING
#asks in the first row, does the year in the row equal to 1981
#then, asks does the second row equal 1982 etc. 

#FILTER BY MULTIPLE CONDITIONS
bigfoot_with_weight <-  filter(surveys, )
#if hindfoot over 40, make sure weight is considered 
bigfoot_with_weight <- filter (surveys, hindfoot_length > 40 & !is.na(weight)) 

# multiple filtering step process
small_animals <- filter(surveys, weight <5) #only want animals with weight less than 5
#define data frame!  
small_animals_id <- select(small_animals,record_id, plot_id, species_id)
#instead of having all of the arguments copied, add data you want to use 
# small_animals_ids <- select((filter(surveys, weight < 5))), record_id, plot_id 
# instead of using filter(surveys) AGAIN, use the new variable small_animals since this already has specified values
small_animals_ids <- select(small_animals, record_id, plot_id, species_id)

#Better way to find data for multiple filtering process USE NESTED FUNCTIONS
small_animals_ids <- select(filter(surveys, weight <5), record_id, plot_id, species_id)
#HOWEVER THIS METHOD IS CLUNKY SAME THING CAN BE DONE USING PIPES

#same process as using a pipe
#command Shift M; only on tidy verse
#    %>% 
small_animals_ids <- filter(surveys, weight<5) %>% select(record_id, plot_id, species_id) 
#R understands that before the pipe is the value that is bases the selection from 

# can use two pipes!
small_animals_ids <- surveys %>% filter(weight <5) %>% select(record_id, plot_id, species_id)


# how to do line breaks with pipes 
surveys %>% filter(month==1)

surveys %>% 
  filter(month == 1) #gives warning sign..? why 

#line break has to be done so that R knows that there is a continuation in the next line 

#BAD EXAMPLE survey
# %>% filter(month==1)

#line break rules: after open parenthesis, pipes, commas, 
# if indented, R understood line break pipes*

