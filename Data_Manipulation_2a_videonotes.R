#Data Manipulation 2a
#run a test if something is true in the test, gives direction 

library(tidyverse)
surveys <- read_csv("data/portal_data_joined.csv")
str(surveys)

summary(surveys$hindfoot_length)

# psuedocode
# ifelse( test or condition, what to do if the test is yes/true, what do if the test is false/no)
# ifelse = test, what to do if yes/true, what to do if no/false
## missing values in test give missing values in the result 

#boolean test
surveys$hindfoot_length< 29.29 # asks data what values are greater than 29.29

surveys$hindfoot_cat <- ifelse(surveys$hindfoot_length < 29.29, yes = "small", no = "big")
head(surveys$hindfoot_cat)
head(surveys$hindfoot_length)

#Another way to do this
surveys$hindfoot_length <- ifelse(surveys$hindfoot_length < mean(
  surveys$hindfoot_length, na.rm = TRUE), yes = "small", no = "big") #na.rm if NA is existant, please take it out function 
head(surveys$hindfoot_cat)
unique(surveys$hindfoot_cat)

# the dollar sign functional tool to call up the column names easily 
#more than 2 category/conditions
# case_when() if else statement but allows you to have endless conditions



#every value gets caught by TRUE ~ "small"
#this method attributes NA values as small too so it is wrong

surveys %>% 
  mutate(hindfoot_cat = case_when(
    hindfoot_length < 29.29 ~ "big", # hindfoot length over mean(29.29) I want to reclassify this as big 
    is.na( hindfoot_length) ~ NA_character_, 
    TRUE ~ "small"  # "else" part 
  )) %>% 
  select(hindfoot_length, hindfoot_cat) %>% 
  head()
# R knows the different types of NA value

#more categories 
surveys %>% 
  mutate(hindfoot_cat = case_when(
    hindfoot_length < 31.5 ~ "big",
    hindfoot_length > 29 ~ "medium",
    is.na( hindfoot_length) ~ NA_character_, 
    TRUE ~ "small" #everything left over will be considered as "small"
  )) %>% 
  select(hindfoot_length, hindfoot_cat) %>% 
  group_by(hindfoot_cat) %>% 
  tally()

# the na value will be refer to as "NA_character_", that's what R recognizes as
#always commas after your case, EXCEPT for the last one
#look at data by writing "view(d)

#why summarize vs. mutate 
#is writing head just to show first few values?
# why are my values different? 
