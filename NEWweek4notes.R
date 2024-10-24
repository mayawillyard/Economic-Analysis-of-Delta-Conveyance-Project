#learning dplyr and tidyr: select, filter, and pipes
#only do this once ever:
install.packages("tidyverse")
#We've learned bracket subsetting
#It can be hard to read and prone to error
#dplyr is great for data table manipulation!
#tidyr helps you switch between data formats

#Packages in R are collections of additional functions
#tidyverse is an "umbrella package" that
#includes several packages we'll use this quarter:
#tidyr, dplyr, ggplot2, tibble, etc.

#benefits of tidyverse
#1. Predictable results (base R functionality can vary by data type) 
#2. Good for new learners, because syntax is consistent. 
#3. Avoids hidden arguments and default settings of base R functions

#To load the package type:
library(tidyverse)
#now let's work with a survey dataset
surveys <- read_csv("data/portal_data_joined.csv")


str(surveys)









#select columns
month_day_year <- select(surveys, month, day, year)

#filtering by equals
year_1981 <- filter(surveys, year == 1981)

#filtering by range
filter(surveys, year %in% c(1981:1983))
#5033 results


#review: why should you NEVER do:
filter(surveys, year == c(1981, 1982, 1983))
#1685 results

#This recycles the vector 
#(index-matching, not bucket-matching)
#If you ever really need to do that for some reason,
#comment it ~very~ clearly and explain why you're 
#recycling!

#filtering by multiple conditions
bigfoot_with_weight <- filter(surveys, hindfoot_length > 40 & !is.na(weight))

#multi-step process
small_animals <- filter(surveys, weight < 5)
#this is slightly dangerous because you have to remember 
#to select from small_animals, not surveys in the next step
small_animal_ids <- select(small_animals, record_id, plot_id, species_id)

#same process, using nested functions
small_animal_ids <- select(filter(surveys, weight < 5), record_id, plot_id, species_id)

#same process, using a pipe
#Cmd Shift M
#or |>
#note our select function no longer explicitly calls the tibble
#as its first element
small_animal_ids <- filter(surveys, weight < 5) %>% select(record_id, plot_id, species_id)

#same as
small_animal_ids <- surveys %>% filter(
  weight < 5) %>% 
  select(record_id, 
         plot_id, species_id)

#how to do line breaks with pipes
surveys %>% filter(
  month==1)


#good:
surveys %>% 
  filter(month==1)

#not good:
surveys %>%
  filter(month==1)
#what happened here?

#line break rules: after open parenthesis, pipe,
#commas, 
#or anything that shows the line is not complete yet




#check out cute_rodent_photos!
#will be updated throughout the quarter
#as a bonus for checking out these videos
#and visiting the code demos on my repository

mini <- surveys[190:209,]
table(mini$species_id)
nrow(mini)

test <- mini %>% filter(species_id %in% c("DM", "NL"))
nrow(test)



#Other things you can do in the tidy verse
#Data Manipulation part 1b
#goals: learn about mutate, group_by, and summarize
library(tidyverse)
surveys <- read_csv("data/portal_data_joined.csv")
str(surveys)

#adding a new column 
# mutate: adds a new column
surveys <- surveys %>% 
  mutate(., weight_kg = weight/1000)
str(surveys)


#add other columns 
surveys <- surveys %>% 
  mutate(., weight_kg = weight/1000,
         weight_kg2 = weight_kg*2)
str(surveys)

surveys$weight_kg = as.character (surveys$weight_kg2)
str(surveys)

#filter out the NAs
ave_weight <- surveys %>% 
  filter(!is.na(weight)) %>% 
  mutate(mean_wegight = mean(weight))
# $ sign vs mutate tidy verse 


str(ave_weight)
nrow(ave_weight) #32283


ave_weight <- surveys %>% 
  filter(complete.cases(.))
nrow(ave_weight) #30676 eliminates everything in the data frame 

surveys %>% 
  group_by(sex, species_id) %>% 
  mutate(mean_weight = mean(weight, na.rm = TRUE))

df <- surveys %>% 
  group_by(sex, species_id) %>% 
  summarize(mean_weight = mean(weight, na.rm = TRUE))

summary(df)
#remove na's 


#sort and arrange
df <- surveys %>% 
  group_by(sex, species_id) %>% 
  filter( sex != "") %>% 
  summarize(mean_weight = mean(weight, na.rm = TRUE)) %>% 
  arrange(mean_weight)

?mutate
?group_by
#challenge 
surveys %>% 
  filter(!is.na(weight)) %>% 
  group_by(year) %>% 
  summarize(max_weight_g = max(weight)) %>% 
  mutate(max_weight_kg = max_weight_g/1000) %>% 
  arrange()
  

d <- surveys %>% 
  select(year, record_id, weight) %>% 
  filter(!is.na(weight)) %>% 
  mutate(weight_kg = weight/1000) %>% 
  group_by(year) %>% 
  summarize (max_weight_g = max(weight),
             max_weight_kg = max(weight)) %>% 
  arrange()
d

nrow(d)  

  
