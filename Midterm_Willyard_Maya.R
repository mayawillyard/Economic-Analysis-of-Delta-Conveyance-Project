# Midterm 
# Question 1
library(tidyverse)
url <- "https://raw.githubusercontent.com/ucd-cepb/R-DAVIS/refs/heads/main/data/tyler_activity_laps_10-24.csv"
lap_data <- read_csv(url)


# Question 2
laps_running <- lap_data %>% 
  filter(sport == "running" ) %>% 
  filter (total_elasped_time <= 60) %>% 
  filter(minutes_per_mile > 10 & minutes_per_mile < 5)

colnames(lap_data)
rownames(lap_data)

# Question 3 & 4 
laps_running <- lap_data %>% 
  filter(sport == "running" ) %>% 
  filter (total_elapsed_time_s <= 60) %>% 
  filter(minutes_per_mile > 10 & minutes_per_mile < 5) %>% 
  mutate( pace = case_when (minutes_per_mile < 6 ~ "fast",
                           minutes_per_mile > 6 & minutes_per_mile < 8 ~ "medium", TRUE ~"slow"), 
          form <- case_when( year == 2024 ~ "new", TRUE ~ "old" ))

# Question 5 
laps_running <- lap_data %>% 
  filter(sport == "running" ) %>% 
  filter (total_elapsed_time_s <= 60) %>% 
  filter(minutes_per_mile > 10 & minutes_per_mile < 5) %>% 
  summarize(mean_steps_per_minute = mean(steps_per_minute)) %>% 
  pivot_wider(names_from = pace, values_from = mean_steps_per_minute) %>% 
  select(slow, medium, fast)
# it doesn't work??

# Question 6 

