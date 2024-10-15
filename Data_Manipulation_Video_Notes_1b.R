# Data Manipulation part 2 (mutate, group_by, and summarize functions)
library(tidyverse)
surveys <- read_csv("data/portal_data_joined.csv")

#Mutate (create new column in your dataset)
surveys <- surveys %>% 
  mutate(weight_kg = weight/1000) #because original data is in grams
str(surveys) #to check what you made

#Add mulitple columns 
surveys <- surveys %>% 
  mutate(weight_kg = weight/1000,
         weight_kg2 = weight_kg*2) #create multiple columns at the same time
str(surveys)

#filter out the NAs
surveys <- surveys %>% 
  filter(!is.na(weight)) %>%  
  mutate(weight_kg = weight/1000,
         weight_kg2 = weight_kg*2)
str(surveys)
head(surveys) #only shows the first 10 columns ONLY TO CHECK 

#Group_by and Summarize
#split data to sepeate groups and perform analysis, then bring it back together
# requires categorical variable to group 
surveys %>% 
  group_by(sex) %>% 
  mutate(mean_weight = mean(weight))
# still no value in the mean weight column
str(surveys)
         
surveys2 <- surveys %>% 
  group_by(sex) %>% 
  mutate(mean_weight = mean(weight))
str(surveys2)
#value for each category 

# weight by each group in the sex column 
surveys3 <- surveys %>% 
  group_by(sex) %>% 
  summarize(mean_weight = mean(weight))
surveys3

#if there is multiple groups we want to know the weight for 
surveys3 <- surveys %>% 
  group_by(sex, species_id) %>% 
  summarize(mean_weight = mean(weight))
surveys3

# order weight in descending/ascending order
#arrange function 
surveys3 <- surveys %>% 
  group_by(sex, species_id) %>% 
  summarize(mean_weight = mean(weight)) %>% 
  arrange(mean_weight)
surveys3
# lowest to highest weight 

#to do highest to lowest weight 
surveys3 <- surveys %>% 
  group_by(sex, species_id) %>% 
  summarize(mean_weight = mean(weight)) %>% 
  arrange(-mean_weight)
surveys3

#sumarrize MULTIPLE VALUES
surveys3 <- surveys %>% 
  group_by(sex, species_id) %>% 
  summarize(mean_weight = mean(weight),
            min_weight = min(weight)) %>% 
  arrange(-mean_weight)
surveys3