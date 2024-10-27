# Homework 4
# Question 1 
library(tidyverse)
surveys <- read_csv("data/portal_data_joined.csv")
str(surveys)
surveys

# Question 2  
surveys %>% 
  filter(weight > 30 & weight < 60) 
#surveys <- select (filter(surveys, weights, c(30:60))) why doesn't this work
#print out first few rows write head(n=?)

# Question 3  
# renaming is the tibble
biggest_critters <- surveys %>% 
  group_by(species_id, sex) %>% 
  filter(!is.na(weight)) %>% 
  summarise(max_weight = max(weight))

biggest_critters  %>% arrange(max_weight)
biggest_critters %>% arrange (-max_weight)

surveys
?tally
?desc

# Question 4
surveys %>% 
  filter(is.na(weight)) %>% #kept all of the NA value and took out the numbers; do this by deleting !
  group_by(species) %>% 
  tally() %>% 
  arrange(desc(n))

surveys %>% 
  filter(is.na(weight)) %>% 
  group_by(plot_id) %>% 
  tally() %>% 
  arrange(desc(n)) # n because the column name is "n"

surveys %>% 
  filter(is.na(weight)) %>% 
  group_by(year) %>% 
  tally() %>% 
  arrange(desc(n))

# Question 5
surveys_avg_weight <- surveys %>% 
  filter(!is.na(weight)) %>% 
  mutate(avg_weight = mean(weight)) %>% 
  group_by(species_id, sex) %>% 
  select (species_id, sex, weight, avg_weight) #why is my weight all the same?/ keep species, sex, weight, and average weight column but deletes the rest  
surveys_avg_weight
# all of my weight is shown as 42.7, how do I fix this? 

# Question 6
surveys_avg_weight <- surveys_avg_weight %>% 
  mutate(above_average = weight > avg_weight) 

surveys_avg_weight
# my weight is still all of the same 

#how to make a mini summary table 
surveys_avg_weight <- surveys %>%  group_by(species_id, sex) %>% 
  summarize(avg_weight= mean(weight), max_weight = max(weight))


