library(tidyverse)

#Midterm review
# doesn't have to be in the same order as the answer key 
# filter (sport == "running" & minute_per_mile <= 10 & minutes_per mile >= 5 & total_elapsed_time_s > 60)
# mutate 
# catches NA Values for answer key method 
# R commutes "and" first then "or" 
# and is the same thing as multiplying 
# or is the same thing as adding 
# bracket all of the or
# braces and brackets don't change 

# Class content 11/7/2024 - homework review
library(ggplot2)
gapminder <- read_csv("https://ucd-r-davis.github.io/R-DAVIS/data/gapminder.csv")

head(gapminder)
gapminder |> group_by(continent) |> summarize(avg_lifeExp = mean(lifeExp))
# |< means piping without tidyverse 
# data = gapminder doesn't pull any data from anything 
# ggplot ( data = the more specific data you want to be pulling in from )

library(tidyverse)
library(ggplot2)

# Actual Class Content 
#Section 1: Plot Best Practices and GGPlot Review####
#ggplot has four parts:
#data / materials   ggplot(data=yourdata)
#plot type / design   geom_...
#aesthetics / decor   aes()
#stats / wiring   stat_...

#Let's see what this looks like:

#Here we practice creating a dot plot of price on carat
ggplot(diamonds, aes(x= carat, y= price)) +
  geom_point()

# all over color 
ggplot(diamonds, aes(x= carat, y = price)) + 
  geom_point (color = "blue")
# color by varaible 
ggplot (diamonds, aes(x= carat, y = price, color = clarity)) + 
  geom_point (alpha = 0.2) + theme_classic()
# theme means you're not a newb 

# add a title and edited the y 
ggplot (diamonds, aes(x= carat, y = price, color = clarity)) + 
  geom_point (alpha = 0.2) + theme_classic() +
  ggtitle( "Price by Diamond Qulaity") + ylab("price in $") +
  stat_smooth(method = "lm")

# curvy line 
ggplot (diamonds, aes(x= carat, y = price, color = clarity)) + 
  geom_point (alpha = 0.2) + theme_classic() +
  ggtitle( "Price by Diamond Qulaity") + ylab("price in $") +
  stat_smooth(method = "loess") # loess makes a curve not a straight line 

# Color Palette Choices and Color-Blind Friendly Visualizations 

# There are four types of palettes
#1 continuous, 2 ordinal, 3 qualitative, 4 diverging (negative values to positive values)

library("RColorBrewer")
display.brewer.all(colorblindFriendly = TRUE)

# Continous data 
ggplot (diamonds, aes(x= carat, y = price, color = clarity)) + 
  geom_point (alpha = 0.2) + theme_classic() +
  scale_color_viridis_c(option = "A", direction = 
                          -1)
# -1 vs 1

# to bin continuous datam use the suffix _b instead
ggplot (diamonds, aes(x= carat, y = price, color = clarity)) + 
  geom_point (alpha = 0.2) + theme_classic() +
  scale_color_viridis_b(option = "A", direction = 
                          -1)

# ORDINAL 
ggplot (diamonds, aes(x= carat, y = price, fill = color)) + 
  
# Outline the data 
  ggplot (diamonds, aes(x= cut, y = carat, color = color, fill = color)) + 
  geom_boxplot(alpha = 0.2) + theme_classic() +
  ggtitle("Diamond Quality by Cut") +
  scale_color_viridis_d("color") +
  sclae_fill_virdis_d("color")

# Barplot 
ggplot (diamonds, aes(x = cut, y = carat, fill = color)) +
  geom_boxplot() + theme_classic 

# Qualitative categorical 
ggplot (iris,
        aes(x= Sepal.Length, y= Petal.Length, fill = Species)) +
  geom_point(shape = 24, color = "black") + theme_classic() +
  ggtitle("Sepal and Petal Length of Three Iris Species") +
  scale_fill_brewer(palette = "Set2")
# shapes have ID Numbers 
# manual color palette 
# name color palette with levels 
cbPalette <- c("#999999", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")
names(cbPalette) <- levels(iris$Species)

# diverging color palettes

#Non visual representation 
mybarplot <- ggplot(diamonds, aes(x=clarity)) +
  geom_bar() +
  theme(axis.text.x = element_text(angle = 70, vjust = 0.5)) +
  theme_classic() +ggtitle("Number of Diamonds by Clarity")

mybarplot

library(BrailleR)
install.packages("BrailleR")
#library(sonify)

detach("package:BrailleR", unload=TRUE)

# Publishing Plots and Saving Figures and Plots
library(cowplot) # install? 

plot.diamonds <- ggplot(diamonds, aes(clarity, fill = cut)) + 
  geom_bar() +
  theme(axis.text.x = element_text(angle=70, vjust=0.5))
#plot.diamonds

plot.cars <- ggplot(mpg, aes(x = cty, y = hwy, colour = factor(cyl))) + 
  geom_point(size = 2.5)
#plot.cars

plot.iris <- ggplot(data=iris, aes(x=Sepal.Length, y=Petal.Length, fill=Species)) +
  geom_point(size=3, alpha=0.7, shape=21)

panel_plot <- plot_grid(plot.cars, plot.iris, plot.diamonds, 
                        labels=c("A", "B", "C"), ncol=2, nrow = 2)

# interactive web applications 
library(plotly)
install.packages("plotly")

plot.iris <- ggplot(data=iris, aes(x=Sepal.Length, y=Petal.Length, 
                                   fill=Species)) +
  geom_point(size=3, alpha=0.7, shape=21)
plotly::ggplotly(plot.iris)
#ggsave and copy and paste that 