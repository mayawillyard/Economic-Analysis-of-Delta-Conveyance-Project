# Homework 5
library(tidyverse)
surveys <- read_csv("data/portal_data_joined.csv")

str(surveys)

# Question 1
surveys_wide <- surveys %>% 
  filter(!is.na(hindfoot_length)) %>% # do you always assume there's an NA value?
  group_by(genus, plot_type) %>% 
  summarize(mean_hindfoot = mean(hindfoot_length)) %>% 
  pivot_wider(names_from = plot_type, values_from = mean_hindfoot) %>% 
  arrange(Control)

# Question 2 
summary(surveys$weight)
# first quartile is 20, second quartile 37, third quartile 48 
# use ifelse to confirm that your conditions are true ? not in the beginning 

## surveys %>% (weight_cat = case_when(
  #weight <= 20.00 ~ "small",
#  weight > 20.00 & weight < 48.00 ~ "medium", 
 # weight > 48 ~ "large", TRUE)) doesn't work?? why 

#surveys %>% mutate (weight_cat = case_when
                   # (weight <= 20.00 ~ "small", 
                    #  weight > 20.00 & weight < 48.00 ~ "medium", 
                     # TRUE ~ "large")) #applies the names to NA values as well
?unique

surveys %>% mutate (weight_cat = case_when(
  weight <= 20.00 ~ "small", 
  weight > 20.00 & weight < 48.00 ~ "medium", 
  weight > 48 ~ "large")) # excludes NAs if it is not mentioned to begin with 

surveys %>% 
  mutate(weight_cat = ifelse(weight <= 20.00, "small", 
                                       ifelse(weight > 20.00 & weight < 48.00, "medium", "large")))
# not "~" use COMMA                                       
                                       
# "middle", "big" means the direct values should be assign to "middle" if otherwise, assign to the second word                                       
# the differnece between an ifelse statement and casewhen is that it doesn't specify what to do if the conidition is false  
# in last week's exmaple we classified NA values as "small" when do we know when to include NA values or not? 


#BONUS Question 
## How might you soft code the values (i.e. not type them in manually) of the 1st and 3rd quartile into your conditional statements in question 2?
summary(surveys$weight)

sumn <- summary(surveys$weight)
surveys %>% mutate (weight_cat = case_when(
  weight <= sumn[2] ~ "small", 
  weight > sumn[2] & weight < sumn[5] ~ "medium", 
  weight > sumn[5] ~ "large")) 

sumn
sumn[1] # gives the name and the value
sumn[[2]] # gives the value 
sumn[[5]]
# two brackets remove the label 