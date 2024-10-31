#Week 3 Homework
library(tidyverse)
surveys <- read.csv("data/portal_data_joined.csv")
colnames(surveys)
surveys

# ALTERNATIVE METHOD
#surveys_base <- surveys %>% select(species_id, weight, plot_type)


surveys_base <- surveys[1:5000, c(6,9,13)] #parenthesis are for FUNCTIONS; Brackets are for specified placements
surveys_base
surveys_base <- surveys_base[complete.cases(surveys_base), ]
surveys_base
surveys_base$species_id <- factor(surveys_base$species_id) #changes factors to integrals
surveys_base$species_id
surveys_base$plot_type <- factor(surveys_base$plot_type)
surveys_base$plot_type

levels(surveys_base$species_id)
?factor

typeof(surveys_base$species_id) #checks what they changed to 
class(surveys_base$plot_type)
