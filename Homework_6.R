# Homework 6
library(tidyverse)
library(ggplot2)
gapminder <- read_csv("https://ucd-r-davis.github.io/R-DAVIS/data/gapminder.csv")

#Question 1
gapminder %>% 
  group_by(continent, year) %>% #gives the data you start with 
  summarise(life_expectancy = mean(lifeExp)) %>% # rename at summarize
  ggplot() + 
  geom_point(aes( x = year, y = life_expectancy, color = continent)) +
  geom_line(aes( x = year, y = life_expectancy, color = continent))
  # what you want to color code is the color = 
# data = mean_lifeexpectancy, mapping = aes( x = year, y = life_expectancy, color = continent)
view(mean_lifeexpectancy)


?geom_line

#Question 2
ggplot(gapminder, aes(x = gdpPercap, y = lifeExp)) +
  geom_point(aes(color = continent), size = .25) + 
  scale_x_log10() +
  geom_smooth(method = 'lm', color = 'black', linetype = 'dashed') +
  theme_bw()

#What do you think the scale_x_log10() line of code is achieving? What about the geom_smooth() line of code?
# The scale_x_log10 is allowing the numerical scale to be simplified in the gdpPercap axis. The geom_line adds a regression line in the plot. 

# Question 3
# %in% "within"

countries <- c("Brazil", "China", "El Salvador", "Niger", "United States")

gapminder %>% 
  filter(country %in% countries) %>% 
  ggplot(aes(x = country, y = lifeExp)) +
  geom_boxplot() +
  geom_jitter(aes(color = "red")) + 
  ggtitle("Life Expectancy of Five Countries") +
  xlab("Country") + ylab("Life Expectancy")
  

?geom_jitter
