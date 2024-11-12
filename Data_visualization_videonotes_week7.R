# Week 7 Video Notes
# Data Visualization part 2a 

library(tidyverse)
library(ggplot2)

# ggplot is like a house 
# 4 parts to a ggplot function 
# part 1: ggplot(data = your data)
# part 2: plot type/design geom() 
# part 3: aesthetics/ decoration 
# part 4: stats is the custom wiring of the house 

#dot plot of price on diamond carats 
ggplot(diamonds, aes(x = carat, y=price)) + 
  geom_point()
# don't forget the parentheses!!

#reflect color to all values
ggplot(diamonds, aes(x = carat, y=price)) + 
  geom_point(color = "blue")

# color by variable 
ggplot(diamonds, aes(x = carat, y=price, color = clarity)) + 
  geom_point(alpha = 0.2)

# use variable to determine what the plot looks like, has to be under the aesthetics 
# if one color, it can go under the "geompoint" 
# alpha increases the transparency 
# clarity colors in gradient: lightest to darkest

# Plot best practices
# remove background, redundant labels, borders, 
# reduce color and special effect 
# remove bolding, lighten labels, remove lines, direct lines 

# How to clean up the background 
ggplot(diamonds, aes(x = carat, y=price, color = clarity)) + 
  geom_point(alpha = 0.2) +
  theme_classic()

# keep visulaization simple with clear message
# start axes at 0 

# Add title and y labels 
# ggtitle to add an overall title to the plot 
# ylab = overwrites the label on the y axis 

ggplot(diamonds, aes(x = carat, y=price, color = clarity)) + 
  geom_point(alpha = 0.2) +
  theme_classic() +
  ggtitle("Price by Diamond Quality") + ylab("price in $") +
  stat_smooth(method = "lm")
# to add a linear regression line, type stat_smooth(method = "lm")

# Add trendcurves/ LOESS trendcurves
# takes average of points in the certain region and keeps shifting to the right 

ggplot(diamonds, aes(x = carat, y=price, color = clarity)) + 
  geom_point(alpha = 0.2) +
  theme_classic() +
  ggtitle("Price by Diamond Quality") + ylab("price in $") +
  stat_smooth(method = "loess")

# doesn't calculate average of a point if there aren't enough data 
