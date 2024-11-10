# Week 7 Video Notes
# Data Visualization part b 

# Color Palette Choices and Color-Blind Friendly Visualization 

# 4 types of palettes: 
# Continuous = decimals, continuous
# Ordinal = plotting categories representing least to most of something - 0,1,2,3,disagree, strongly disagree, etc. 
# Qualitative = showing different categories of something that are non ordered (different types of pizza)
# diverging = plotting a range that includes negative values and positive values 

# RColorBrewer 
library("RColorBrewer")
display.brewer.all(colorblindFriendly = TRUE)
# first chunk good for continous data 
# qualitative data is from set 2 and the three rows below
# diverging data is the last third chunk 

# Continous data 
ggplot(diamonds, aes(x = clarity, y = carat, color = price)) +
  geom_point(alpha = 0.2) + theme_classic() +
  scale_color_viridis_c(Option = "A", direction = -1)
# -1 used to reverse the direction of the colorscale 
# _c means continous data 
# it shows error?? why won't this run 

# Different Virdis color scheme 
ggplot(diamonds, aes(x = clarity, y = carat, color = price)) +
  geom_point(alpha = 0.2) + theme_classic() +
  scale_color_viridis_c(Option = "E", direction = -1)

# to bin continous data, use the suffix "_b" instead
# b for binned 
# each levels are a different color not a gradient 
# conitnous data use c or b 

# Ordinal data 
# has a specific order 
ggplot(diamonds, aes(x = cut, y = carat, fill = color)) +
  geom_boxplot() + theme_classic() +
  ggtitle("Diamond Quality by cut") +
  scale_fill_viridis_d("color")
# d for discrete 
# used fill to color inside boxplot 
# scale_color vs scale_fill 

#change the aes parameter from fill = to color = to match 
ggplot(diamonds, aes(x = cut, y = carat, color = color)) +
  geom_boxplot(alpha = 0.2) + theme_classic() +
  ggtitle("Diamond Quality by cut") +
  scale_color_viridis_d("color")

# this outlines the boxplot 

# How Ordinal and Continous data looks like on a barplot
ggplot(diamonds, aes(x = clarity, fill = cut)) +
  geom_bar() + 
  theme(axis.text.x = element_text (angle = 70,vjust = 0.5)) +
  scale_color_viridis_d("cut", option = "B") + 
  theme_classic()

# start from template to make ggplot 

# from RColorBrewer
ggplot(diamonds, aes(x = cut, y = carat, fill = color)) +
  geom_boxplot() + theme_classic() +
  ggtitle("Diamond Quality by cut") +
  scale_fill_brewer(palette = "PuRd")

# PuRd from brewer display chart 
# display.brewer.all(colorblindFriendly = TRUE)

# Qualitative Data
ggplot(iris, 
       aes ( x = Sepal.Length, y = Petal.Length, fill = Species)) +
  geom_point(shape = 24, color = "black", size = 4) + theme_classic() +
  ggtitle("Sepal and Petal Length of Three Iris Species") +
  scale_fill_brewer(palette = "Set2")
# set 2 from same display brewer chart 
# fill = the data inside the chart 
# shape = 24 indicates traingle, color in point can change border outline, and size needs to be included to make it big

#NO SIZE -- example of bad sizing 
ggplot(iris, 
       aes ( x = Sepal.Length, y = Petal.Length, fill = Species)) +
  geom_point(shape = 24, color = "black") + theme_classic() +
  ggtitle("Sepal and Petal Length of Three Iris Species") +
  scale_fill_brewer(palette = "Set2")

#GGtheme packages
library(ggthemes)
ggplot(iris, 
       aes ( x = Sepal.Length, y = Petal.Length, fill = Species)) +
  geom_point() + theme_classic() +
  ggtitle("Sepal and Petal Length of Three Iris Species") +
  scale_color_colorblind("Species") +
  xlab("Sepal Length in cm") +
  ylab("Petal Length in cm")

installed.packages(ggthemes)
install.packages(ggthemes)
# ask in drop in lab how to get this? 

#Manual Palette Design 
# create a named vector 
cbPalette <- c("#999999","#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55F00", "#CC79A7")
names(cbPalette) <- levels(iris$Species)
# we don't need all of the colors since there are only 3 species 
# we cut the vector length 
cbPalette <- cbPalette[1:length(levels(iris$Species))]

# Example
ggplot(iris, 
       aes ( x = Sepal.Length, y = Petal.Length, color = Species)) +
  geom_point() + theme_classic() +
  ggtitle("Sepal and Petal Length of Three Iris Species") +
  scale_color_manual(values = cbPalette) +
  xlab("Sepal Length in cm") +
  ylab("Petal Length in cm")
# WARNING MESSAGE?? "no shared levels between names(values) of the manual scale and the data's color values 
# the aes function must be color = NOT FILL 

# Diverging discrete 
# from RColorBrewer
# data is diverging from the average to large 

myiris <- iris %>% group_by(Species) %>% mutate(size = case_when(
  Sepal.Length >1.1* mean(Sepal.Length) ~ "very large",
  Sepal.Length <0.9* mean(Sepal.Length) ~ "very small", 
  Sepal.Length <0.94* mean(Sepal.Length) ~ "small", 
  Sepal.Length < 1.06* mean(Sepal.Length) ~ "large", 
  TRUE ~ "average"))

# set variables from smallest to largest 
myiris$size <- factor(myiris$size, levels = c("very small", "small", "average","large", "very large"))

# custom variable completed so now run this 
ggplot(myiris, aes( x = Petal.Width, y = Petal.Length, color = size)) +
  geom_point(size = 2) + theme_gray() +
  ggtitle("Diamond Quality by Cut") +
  scale_color_brewer(palette = "RdYlBu")
# lightest color is the average and gets dramatic on both end of spectrums

# Data Visualization part 2c 
# Non-visual representation 
# Braille package
# install.packages(BrailleR) why can't I install it?
mybarplot <- ggplot(diamonds, aes(x=clarity)) +
  geom_bar()+
  theme(axis.text.x = element_text (angle = 70, vjust = 0.5)) +
  theme_classic() +ggtitle("Number of Diamonds by Clarity")
mybarplot

VI(mybarplot)

library(sonify)
plot(iris$Petal.Width)
sonify(iris$Petal.Width)
# sonify = higher pitch for things on the top of the graph and lower pitch for things in the lower part of the graph 
detach("package:BrailleR", unload = TRUE)

# Publishing Plots and Saving Figures & Plots 
install.packages("cowplot")
# ALWAYS PUT QUOTATION WHEN YOU ARE DOWNLOADING 
library(cowplot)

# Example
plot.diamonds <- ggplot(diamonds, aes(clarity, fill = cut)) +
  geom_bar() +
  theme(axis.text.x = element_text(angle = 70, vjust = 0.5))

plot.diamonds

# cars plot 
plot.cars <- ggplot(mpg, aes(x = cty, y= hwy, color= factor(cyl))) +
  geom_point(size = 2.5)

plot.cars

# iris plot 
plot.iris <- ggplot(data = iris, aes(x=Sepal.Length, y= Petal.Length, fill = Species)) +
  geom_point(size = 3, alpha = 0.7, shape = 21)

plot.iris

# use plot grid 
panel_plot <- plot_grid(plot.cars, plot.iris,plot.diamonds, 
                        labels = c("A", "B", "C"), ncol = 2, nrow = 2)
panel_plot
# it gives three graphs with three columsn and 2 rows 

# How to fix sizes over a panel plot 
fixed_gridplot <- ggdraw() + draw_plot(plot.iris, x= 0, y=0, width = 1, height = 0.5) +
  draw_plot(plot.cars, x=0, y=0.5, width = 0.5, height = 0.5) +
  draw_plot(plot.diamonds, x=0, y= 0.5, width = 0.5, height = 0.5) +
  draw_plot_label(label = c("A", "B", "C"), x = c(0,0.5,0), y = c(1,1,0.5))
fixed_gridplot
# last list of x and y is telling R what value the axes starts with 

# Saving Figures 
ggsave("figures/gridplot.png", fixed_gridplot)
# you can save as .png, .jpeg, .tiff, .pdf, .bmp, or .svg

# for publication use dpi of at least 700 
ggsave("figures/gridplot.png", fixed_gridplot,
       width = 6, height = 4, units = "in", dpi = 700)

# Interactive web applications 
library(plotly)

plot.iris <- ggplot(data = iris, aes(x=Sepal.Length, y= Petal.Length, fill = Species)) +
  geom_point(size = 3, alpha = 0.7, shape = 21)

plotly::ggplotly(plot.iris)
