# Week 7 Homework 
library(tidyverse)
library(ggplot2)
gapminder <- read_csv("https://ucd-r-davis.github.io/R-DAVIS/data/gapminder.csv")

# first, separate population for 2002 and 2007 out of bigger data 

str(gapminder)

pc <- gapminder %>% 
  select(continent, year, pop, country) %>% 
  filter(year > 2000) %>% 
  filter(!continent == "Oceania") %>% 
  pivot_wider(names_from = "year", values_from = "pop") %>% 
  mutate(population_change = `2007`-`2002`)

# column name that is numbers use tick mark/ or column names with spaces
# TAKE OUT OCEANIA in the FIRST STEP
# how do you look at data within data? 
# to TAKE OUT a value, the exclamation always go in the beginning 

pc
?facet_wrap

# Make GGPLOT now 
pc %>% ggplot(aes((x = fct_reorder(country,population_change)), y = population_change)) +
  geom_bar(aes(fill= continent), stat = "identity")+
  theme(axis.text.x = element_text (angle = 45,vjust = 1)) +
  scale_fill_colorblind("pop") +
  xlab("Country") +
  ylab("Change in Population Between 2002 and 2007") +
  facet_wrap(~ continent, scale = "free")
# axis.text.x = well customize the x axis ONLY 
# scale = free  well cater the scale for each data type 
# if no scale, all of the data will be the same 
# REORDER makes the values smallest to largest OR put minus to make is descending values 
# geom_col NOT geom_bar UNLESS you have stat = "identity"
# geom_col by default counts the value in relation to y values but bar would only count the values 
# geom_col shows VALUES 
#coord_flip () can flip the variable axis 

?geom_col
# this is called the helpfile 