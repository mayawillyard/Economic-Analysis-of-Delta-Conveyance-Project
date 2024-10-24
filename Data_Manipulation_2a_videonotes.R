#Data Manipulation 2a
#run a test if something is true in the test, gives direction 

library(tidyverse)
surveys <- read_csv("data/portal_data_joined.csv")
str(surveys)

summary(surveys$hindfoot_length)

#psuedocode
# ifelse( test or condition, what to do if the test is yes/true, what do if the test is false/no)

#boolean test
surveys$hindfoot_length< 29.29 # asks data what values are greater than 29.29

surveys$hindfoot_cat <- ifelse(surveys$hindfoot_length < 29.29, yes = "small", no = "big")
head(surveys$hindfoot_cat)
head(surveys$hindfoot_length)

#Another way to do this
surveys$hindfoot_length <- ifelse(surveys$hindfoot_length < mean(
  surveys$hindfoot_length, na.rm = TRUE), yes = "small", no = "big") 
head(surveys$hindfoot_cat)

#more than 2 category/conditions
# case_when()

#every value gets caught by TRUE ~ "small"
#this method attributes NA values as small too so it is wrong

surveys %>% 
  mutate(hindfoot_cat = case_when(
    hindfoot_length < 29.29 ~ "big",
    is.na( hindfoot_length) ~ NA_character_, 
    TRUE ~ "small"
  )) %>% 
  select(hindfoot_length, hindfoot_cat) %>% 
  head()
# R knows the different types of NA valuea 

#more categories 
surveys %>% 
  mutate(hindfoot_cat = case_when(
    hindfoot_length < 31.5 ~ "big",
    hindfoot_length > 29 ~ "medium",
    is.na( hindfoot_length) ~ NA_character_, 
    TRUE ~ "small"
  )) %>% 
  select(hindfoot_length, hindfoot_cat) %>% 
  group_by(hindfoot_cat) %>% 
  tally()

#is writing head just to show first few values?
# why are my values different? 
