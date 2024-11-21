# Homework 8
library(dplyr)
library(readr)
library(lubridate)
library(tidyverse)
library(ggplot2)
library(ggthemes)
library("RColorBrewer")

mloa <- read_csv("https://raw.githubusercontent.com/ucd-cepb/R-DAVIS/master/data/mauna_loa_met_2001_minute.csv")
head(mloa)

tz(mloa$datetime) # UTC, why isn't this an actual timezone? 
glimpse(mloa)
?strptime
View(mloa)

mloa1 <- mloa %>% filter(!is.na(rel_humid)) %>% 
  filter(!is.na(temp_C_2m)) %>% 
  filter(!is.na(windSpeed_m_s)) %>% 
  mutate(date_time = paste(mloa$year, "-", mloa$month, 
                           "-", mloa$day, ",", mloa$hour24, ":",
                           mloa$min), sep = "", tz = "UTC") %>% 
  mutate(datetimeLocal = with_tz(date_time, tz = "Pacific/Honolulu")) 
  
  

mloa1 <- mloa %>% filter(!is.na(rel_humid)) %>% 
  filter(!is.na(temp_C_2m)) %>% 
  filter(!is.na(windSpeed_m_s)) %>% 
  mutate(date_time = paste0(mloa$year, "-", mloa$month, 
                            "-", mloa$day, ",", mloa$hour24, ":",
                            mloa$min), tz = "UTC") %>% 
  mutate(datetimeLocal = with_tz(date_time, tz = "Pacific/Honolulu")) 
# why doesn't ymd_hs not working? also included sep = "" but it still didn't work 

mloa1

mloa1 %>% mutate(local_month = month(datetimeLocal, label = TRUE),
                 local_hour = hour(datetimeLocal)) %>% 
  group_by(local_month, local_hour) %>% 
  summarize(meantemp = mean(temp_C_2m)) %>% 
  ggplot(aes(x = local_month, 
         y = meantemp)) + 
  geom_point(aes
             (col = local_hour)) + 
  scale_fill_viridis_c() +
  xlab ("Month") +
  ylab ("Mean of Temperature") + 
  theme_classic()

# aesthethics twice becuse you need to decide the details of the design for each part of the plot??
# why no label = TRUE in local_hour??
# why is geom_point not running? 
display.brewer.all(colorblindFriendly = TRUE)

tz(mloa1$datetime)
?as_datetime
#what's the x value here??



## how do we extract specific components of the lubridate object? 
# use day(), month(), year()
#months <- month(mloa2$datetime)
#table(months)
# summary of when the data was observed in 
# the name of the months are in numbers 

# make that data more readable through label 
#months <- month(mloa2$datetime, label = TRUE, abbr = TRUE)
#table(months)