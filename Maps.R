################# DUNGENESS CRAB DATA 2007-2018 (NOAA) ####################


################ set working directory ###############################

#To sweep environment
rm(list = ls())

setwd('C:/Users/e/Desktop/Kirk REU FHLOO Data')

###############load libraries #############################
library(ggplot2)
library(scales)
library(grid)
library(dplyr)
library(lubridate)
library(readxl)
library(tidyr)
library(plotly)
library(dygraphs)
library(xts)          # To make the conversion data-frame / xts format
library(tidyverse)
library(zoo)

install.packages(c('devtools','curl'))
library('devtools')
devtools::install_github("dkahle/ggmap")

library(ggmap)

################ Open NOAA Data as CSV ######################

# Read the data, turn nonexistent data to "NaN"
Crab <- read.csv('DungenessCrab_NOAA_2007-2018_No_NA.csv', na.strings=c("-9999","NaN"))

# Read the data, turn nonexistent data to "NaN"
Crab <- read.table("DungenessCrab_NOAA_2007-2018_No_NA.csv", na.strings=c("-9999","NaN"), header=T, sep=",") 

colnames(Crab)

class(Crab$date_yyyymmdd)


# Change date from character string to date string 
Crab$Date <- as.Date(Crab$date_yyyymmdd, format = "%Y-%m-%d")

class(Crab$Date)
#Why is the column "NA" but date class?????

# Initialize empty variable first
Crab$Depth <- NA

#Create 3 different thresholds for Depth
Crab$Depth <- cut(Crab$depth_m, breaks = c(-Inf, 100, 200, Inf),
                  labels = c("40-100 m", "100-200 m", "200+ m"))


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Create a map ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Plot cores on a lat/long coordinate plane
map <- ggplot(data = Crab, aes(x = longitude_dd, y = latitude_dd)) + 
  geom_point() + # Add coordinate data
  theme_bw() + # Change the plot theme
  ggtitle("Locations of Dungeness Crab CPUE") + # Give the plot a title
  xlab("Longitude") + # Change x axis title
  ylab("Latitude") # Change y axis title

print(map)
#Not printing????

?left_join

