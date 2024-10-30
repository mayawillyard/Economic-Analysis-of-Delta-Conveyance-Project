# Data Manipulation part 2b (joint, pivot)
#finish homeowrk 5 before exam / finish by thursday 

#joins = two data frame you are combining together 
#join function works row wise (common column names and join row to row to see where it matches up) 
#left join - keeps everything in the first data frame and right joint - keeps everything in the second data frame 
#left joins keeps everything in the original data and adds the match as a new row 
# right joins are the opposite function; never use right joint? do left joint and inner left join

#full joined = just merges everything/ look for common column names 


library(tidyverse)
tail <- read_csv("data/tail_length.csv")
surveys <- read_csv("data/portal_data_joined.csv")

dim(tail)
dim(surveys)
head(tail)

inner_join(x = surveys, y= tail)
surveys_inner <- inner_join(x = surveys, y=tail)


dim(surveys_inner)
head(surveys_inner)

all(surveys$record_id %in% tail$record_id)
all(tail$record_id %in% surveys$record_id)

surveys_left <- left_join (x = surveys, y = tail)
dim(surveys_left)
?dim

surveys_right <- right_join( x= surveys, y = tail)
dim(surveys_right)
surveys_left_right_equivalent <- left_join (x = surveys, y= tail)# tyler was too fast 
#R assumes that the first is x and second is y
dim(surveys_left)
table(is.na(surveys_left$tail_length))


#if joining tables that have nothing in common 
tail %>% select(-record_id)
#left_join(surveys, tail %>% select(-record_id)) 

left_join(surveys, tail %>% rename(record_id2 = record_id), by= c("record_id" = "record_id2"))
?cross_join

#pivots
#changes shapes
#pivot wider = more rows to more columns 
#pivot longer = more colomns to more rows 

surveys_mz <- surveys %>% 
  filter(!is.na(weight)) %>% 
  group_by(genus, plot_id) %>% 
  summarize(mean_weight = mean(weight))
surveys_mz
surveys_mz %>%  pivot_wider(id_cols = "genus", 
                            names_from = "plot_id",
                            values_from = "mean_weight")




## Actual video notes (pivots, joins)
## joining = bringing data frames togther so bringing data frame A and B and you want to combine them or join them togtether 
## pivots = changing data frame longer or wider 
## 
library (tidyverse)
tail <- read_csv("data/tail_length.csv")
head(tail)
dim(tail)

#psuedo code
# every join function in the tidyverse join_function(data frame a, data frame b, how to join)
#inner_join = match merge on common columns and get rid of the rest 
# inner_join = (data frame a, data frame b, common_id)

surveys <- read_csv("data/portal_data_joined.csv")
dim(inner_join(x = surveys, y = tail, by = "record_id"))
dim(surveys)
dim(tail)
# inner_join only keeps records that are in both data frames  

#left_join
#left_join takes dataframe x and dataframe y and looks for any ID in y that exists in x and it takes those values of y and appends it to x 
# keeps everything in the left hand side and matches only on the right hand side 
# left_join(x,y) == right_join(y,x) 

#right_join
# keeps everythign in the right hand side and matches everything on the left hand side
# right_join(x,y) == left_join(y,x) 

surveys_left_joined <- left_join(x=surveys, y=tail, by = "record_id")
surveys_right_joined <- right_join (y=surveys, x=tail, by = "record_id")

dim(surveys_left_joined)
dim(surveys_right_joined)

#full join (x,y)
# full_join keeps EVERYTHING
 
full_join(x = surveys, y=tail)
surveys_full_joined <- full_join (x=surveys, y=tail)
dim(surveys_full_joined)

#pivots
# also called as reshaping long to wide or vice versa
# every variable has column 
# observation has row 
# observational unit has a table 
# each value has its own cell 

#never combining two data change how we array the cells
#pivot_wider makes data with more columns 
pivot_wider()

#pivot_longer makes data with more rows 
pivot_longer()

surveys_mz <- surveys %>% 
  filter(!is.na(weight)) %>% 
  group_by(genus, plot_id) %>% 
  summarize(mean_weight = mean(weight))

surveys_mz
unique(surveys_mz$genus)

# looks like a cross table

wide_survey <- surveys_mz %>% 
  pivot_wider(names_from = "plot_id", values_from = "mean_weight") #names_from taking columns name from specific variable
#valeus from is where you want to take the values from 

head(wide_survey)
# puts NA value back 
# long format of data storage is better!! 

#pivot long example
wide_survey <- surveys_mz %>% 
  pivot_wider(names_from = "plot_id", values_from = "mean_weight")

surveys_long <- wide_survey %>% pivot_longer(-genus, names_to = "plot_id", values_to = "mean_weight")
# minus means that leave column alone 
head(surveys_long)

# if we ran it with out "-genus" then we get an error because give at least column that is not being modified 
# if you don't specify values to, then in case because there's only one value in the matrix

#specify has few things as possible
