# Week 6 Data Visualization part 1 (intro to ggplot, boxplot)

library(tidyverse)
install.packages("ggplot2")

library(ggplot2)

surveys_complete <- read_csv("data/portal_data_joined.csv") %>% 
  filter(complete.cases(.))

#Syntax for ggplot 
## ggplot( data= <DATA>, mapping = aes(<WHERE YOU WANT R TO GET THE DATA FROM/COLUMN NAMES>)) + <GEO METRIC FUNCTION> ()
# aes = aesthethics 
# add anyhting to your plot = use + sign

#Example 
ggplot(data = surveys_complete)

# add aesthic argument 
ggplot(data = surveys_complete, mapping = aes(x= weight, y=hindfoot_length))

#add geom_function 
# two continous variables you want to plot, use geom point, geom ime to see variables
ggplot(data = surveys_complete, mapping = aes(x= weight, y=hindfoot_length)) + 
  geom_point()

# Add more plot elements
# add transparency to the points 
ggplot(data = surveys_complete, mapping = aes(x= weight, y=hindfoot_length)) + 
  geom_point(alpha = 0.1)
# 0 = completely transparent, 1 = not transparent at all 

# add colors to the points
# color cheat sheet: https://www.nceas.ucsb.edu/sites/default/files/2020-04/colorPaletteCheatsheet.pdf
ggplot(data = surveys_complete, mapping = aes(x= weight, y=hindfoot_length)) + 
  geom_point(color = "blue")

# color by group 
ggplot(data = surveys_complete, mapping = aes(x= weight, y=hindfoot_length)) + 
  geom_point(aes(color = genus)) +
  geom_smooth(aes(color = genus)) # to plot a line per genus

# color by genus

# universal plot setting (simply equation above)
ggplot(data = surveys_complete, mapping = aes(x= weight, y=hindfoot_length, color = genus)) + 
  geom_point() +
  geom_smooth() 
# color by genus for any additional geom function I add to this plot by adding "color = genus"

# boxplot: categorical and continous data 
ggplot(data = surveys_complete, mapping = aes(x=species_id, y=weight) +
         geom_boxplot (color = "orange")
# if you want inside to be orange color not the outline, use "fill" 

ggplot(data = surveys_complete, mapping = aes(x=species_id, y=weight) +
         geom_boxplot (fill = "orange") +
         geom_jitter(color = "black", alpha = 0.1)
       # plots points but random variation on how the points go on the plot/ show that multiple points exist in a plot
       # points = points can cluster; jitter spreads out the points 

# change the order of plot consturction 
ggplot(data = surveys_complete, mapping = aes(x=species_id, y=weight) +
         geom_jitter(color = "black", alpha = 0.1) +
         geom_boxplot (fill = "orange", alpha = 0.5) 
       
       