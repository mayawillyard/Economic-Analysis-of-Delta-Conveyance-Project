# Week 6 Data Visualization part 1 (intro to ggplot, boxplot)

library(tidyverse)
install.packages("ggplot2")

library(ggplot2)
# ggplot is based on the grammar of graphics
# components: a data set, coordinate system and geoms - visual marks that represent data points 

surveys_complete <- read_csv("data/portal_data_joined.csv") %>% 
  filter(complete.cases(.))
?ggplot
#Syntax for ggplot 
## ggplot( data= <DATA>, mapping = aes(<WHERE YOU WANT R TO GET THE DATA FROM/COLUMN NAMES>)) + <GEO METRIC FUNCTION> ()
# aes = aesthethics 
# add anything to your plot = use + sign / adding layers to the plot 


#Example 
ggplot(data = surveys_complete)

# add aesthic argument 
ggplot(data = surveys_complete, mapping = aes(x= weight, y=hindfoot_length))

#add geom_function 
# two continous variables you want to plot, use geom point, geom ime to see variables
ggplot(data = surveys_complete, mapping = aes(x= weight, y=hindfoot_length)) + 
  geom_point()

?geom_point # creates scatter plots 

# Add more plot elements
# add transparency to the points 
ggplot(data = surveys_complete, mapping = aes(x= weight, y=hindfoot_length)) + 
  geom_point(alpha = 0.1)
# 0 = completely transparent, 1 = not transparent at all 

#Class example 
ggplot(data = surveys_complete, mapping = aes(x= weight, y=hindfoot_length)) + 
  geom_point(aes(color = genus)) +
  geom_smooth(aes(color = genus))

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
# ggplot is creating coordinate system, adding layers on top, not changing the data so NOT PIPE FUNCTION 
# scale_color function can reclassify the colors

# boxplot: categorical and continous data 
ggplot(data = surveys_complete, mapping = aes(x=species_id, y=weight)) +
         geom_boxplot(aes(color = "orange"))
# if you want inside to be orange color not the outline, use "fill" 
# two calls ggplot and geomboxplot

ggplot(data = surveys_complete, mapping = aes(x=species_id, y=weight)) +
         geom_boxplot (fill = "orange") +
         geom_jitter(color = "black", alpha = 0.1)
       # plots points but random variation on how the points go on the plot/ show that multiple points exist in a plot
       # points = points can cluster; jitter spreads out the points 

# change the order of plot consturction 
ggplot(data = surveys_complete, mapping = aes(x=species_id, y=weight)) +
         geom_jitter(color = "black", alpha = 0.1) +
         geom_boxplot (fill = "orange", alpha = 0.5) 
       
# bonus from homework example

sumn <- summary(surveys$weight)

surveys %>% mutate (weight_cat = case_when(
  weight <= sumn[2] ~ "small", 
  weight > sumn[2] & weight < sumn[5] ~ "medium", 
  weight > sumn[5] ~ "large")) 

ggplot(data = surveys_wtcat, aes(x=weight_cat, y= hindfoot_length)) +
  geom_boxplot(aes(color = weight_cat, alpha = weight)) +
  geom_point(alpha = 0.1)

## what if I want to swtich order of weight_cat? factor! 
surveys_wt_cat$ weight_cat <- factor (surveys_wt_cat$weight_cat, c("small, "medium", "large""))

ggplot( data = surveys_wt_cat, aes(x = weight_cat, y= hindfoot_length)) + 
  geom_boxplot(aes(color = weight_cat), alpha = 0.8 ) + 
  geom_jitter(alpha =0.1)
# switch the order, then 