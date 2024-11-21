# Week 8 Video Notes
# how to format date and time 
# Three types: Dates, posixt(calendar time), posixlt (local time)

# separate date by strings with commas and quotes 
sample_dates_1 <- c("2018-02-01", "2018-03-21", "2018-10-05", 
                    "2019-01-01", "2019-02-18")

class(sample_dates_1)
# convert into a Date object 
sample_dates_1 <- as.Date(sample_dates_1)
class(sample_dates_1)
sample_dates_1
# formated well 
# Month, Day, Year is the WRONG FORMAT 
# it must be write in Year, Month, Day
# string must be in year-month-day format

# Example
sample_dates_2 <- c("02-01-2018", "03-21-2018", "10-05-2018", 
                    "01-01-2019", "02-18-2019")
sample_dates_2

sample_dates_2 <- as.Date(sample_dates_2)
sample_dates_2
# NA VALUES and wrong year like year 0002 

# to fix this, you must specify the format
sample_dates_3 <- as.Date(sample_dates_2, format = "%m-%d-%Y")
sample_dates_3
?strptime
# resource for formatting option 

#Challenge 
as.Date("Jul 04, 2019", format = 
          "%b%d,%Y") # lowercase y is two digit number and uppercase y is four digit

#when working with time, POSIXct is the best class to work with 
tml <- as.POSIXct("2016-07-24 23:55:26")

tml

tm2 <- as.POSIXct("25072016 08:32:07", format = "%d%m%Y %H:%M%S")
tm2
# POSIXct assumes that you are collecting data in the time zone your computer is set up to
#you can set your own timezone in your equation by using tz = 

tm3 <- as.POSIXct("2010-12-01 11:42:03", tz = "GMT")

# Tidyverse method of time 
install.packages("lubridate")
library(lubridate)

sample_dates_1 <- c("2018-02-01", "2018-03-21", "2018-10-05", 
                       "2019-01-01", "2019-02-18")

sample_dates_lub <- ymd(sample_dates_1)
sample_dates_lub

#no two digit for the month 
sample_dates_2 <- c("02-01-2018", "03-21-2018", "10-05-2018", 
                    "01-01-2019", "02-18-2019")
sample_dates_lub2 <- mdy(sample_dates_2)
sample_dates_lub2

#lubridate can use spelled out months and nospace dmy without specification as well 
lubridate:: ymd("2016/01/01")
lubridate:: ymd("2011-03-19")
lubridate:: mdy("Feb 19, 2011")
lubridate:: dmy("22051997")

# more detailed times can be coded as well 
# hms = hours, minutes, seconds
# _ hms or hm

lubridate::ymd_hm("2016-01-01 12:00", 
                  tz = "America/Los_Angeles")
# 24 hour military time 
lubridate::ymd_hm("2016/04/05 14:47",
                  tz = "America/Los_Angeles")

latime <- lubridate::ymd_hms("2016/04/05 4:47:21 PM",
                             tz = "America/Los_Angeles")

# how to change time zones
with_tz (latime, tz= "GMT")
with_tz (latime, tz= "Pacific/Honolulu")

# start as character string not as dates and times
library(dplyr)
library(readr)

mloa1 <- read_csv("https://raw.githubusercontent.com/ucd-cepb/R-DAVIS/master/data/mauna_loa_met_2001_minute.csv")
head(mloa1)

# import raw dataset and specify column types 
mloa2 <- read_csv("https://raw.githubusercontent.com/ucd-cepb/R-DAVIS/master/data/mauna_loa_met_2001_minute.csv",
                  col_types = "cccccccddddddd")
# 7 cs and 7 ds

class(mloa1$year)


glimpse(mloa1)
glimpse(mloa2)

# now we are ready to make datetime col
mloa2$datetime <- paste(mloa2$year, "-", mloa2$month, 
                        "-", mloa2$day, ",", mloa2$hour24, ":",
                        mloa2$min, sep = "")
head(mloa2$datetime)
# separation is an empty string because we want them to be together 

glimpse(mloa2)

# now ready to lubridate data by using POSIXct
mloa2$datetime_test <- as_datetime(mloa2$datetime, 
                                   tz = "America/Los_Angeles", 
                                   format = "%Y-%m-%d, %H:%M")

head((mloa2$datetime))
head(mloa2$datetime_test)
# wrong time zone it is in honolulu 
mloa2$datetime_test2 <- as_datetime(mloa2$datetime, 
                                    tz = "Pacific/Honolulu",
                                    format = "%Y-%m-%d, %H:%M")
# doesn't ask what order to look for the data in 

# have to specify format with as_datetime 
# instead, use ymd_hm 
mloa2$datetime_test2 <- ymd_hm(mloa2$datetime, 
                               tz = "Pacific/Honolulu")
# you have to use it in the same order of y,m,d,h,m

# alternatively, you can wrap as a as. character
mloa1$datetime <- ymd_hm(as.character(mloa2$datetime), 
                         tz = "Pacific/Honolulu")

tz(mloa1$datetime)
# ask what is the timezone of the data

# how do we extract specific components of the lubridate object? 
# use day(), month(), year()
months <- month(mloa2$datetime)
table(months)
# summary of when the data was observed in 
# the name of the months are in numbers 

# make that data more readable through label 
months <- month(mloa2$datetime, label = TRUE, abbr = TRUE)
table(months)

# how to check daylight savings time dst
dst(mloa2$datetime_test[1]) # asks if data was in daylight savings time
dst(mloa2$datetime) # same length as the number of rows

latime
dst(latime)
gm <- with_tz(latime, tz = "GMT")
dst(gm)
hi <- with_tz(latime, tz = "Pacific/Honolulu")
dst(hi)
# hawaii doesn't do daylight savings time 

# How to subtract dates
seq(1,10,1)
seq(mdy("01-01-2020"), mdy("10-01-2020"), by = 1)
# ways to create arbitary dates

mdy("01-01-2020") - months(2)
# as works on a column because it treats it as a column 
# does this mean that it doesn't work on a row? 
# date hack that can be used 
decimal_date(mdy("10-01-2020"))
date_decimal(decimal_date(mdy("10-01-2020")))
