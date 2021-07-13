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

#~~~~~~~~~~~~~~~~~~~ Create Bins for Depth ~~~~~~~~~~~~~~~~~~~~~~~

# Initialize empty variable first
Crab$Depth <- NA

#Create 3 different thresholds for Depth
Crab$Depth <- cut(Crab$depth_m, breaks = c(-Inf, 100, 200, Inf),
                  labels = c("40-100 m", "100-200 m", "200+ m"))




#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Plot CPUE vs O2 Concentration ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

CPlot <- ggplot(data = Crab, aes(x = o2_ml_per_l, y = cpue_kg_per_ha_der, color = Depth)) +
  geom_point(alpha = 0.5) + xlab("Dissolved Oxygen (mL/L)") + #last x label sets the time axis label
  ylab("CPUE (kg/ha)") +
  ggtitle("Catch Per Unit Effort at Various Oxygen Concentrations") + 
  theme_minimal() +
  scale_x_continuous(name="Dissolved Oxygen (mL/L)", breaks=c(0,1,2,3,4,5,6)) +
  scale_y_continuous(name="CPUE (kg/ha)", breaks=c(50, 100, 150, 200, 250, 300)) +
  theme(panel.grid.major = element_line(colour = "grey", size = 0.25),  #theme for bottom plot
        panel.grid.minor = element_line(colour = "grey", size = 0.25),
        axis.title.x= element_text(size =12,lineheight=3),
        axis.text.x= element_text(size =10),
        axis.text.y = element_text(size =10),
        axis.ticks.x=element_blank(),
        axis.title.y = element_text(size =12,lineheight=3)) 
  

ggplotly(CPlot)


#Save as static image


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Plot o2 v temp vs depth bin ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

CPlot <- ggplot(data = Crab, aes(x = temp, y = o2_ml_per_l, color = Depth)) +
  geom_point(alpha = 0.5) + xlab("Water Temperature (°C)") + #last x label sets the time axis label
  ylab("Dissolved Oxygen (mL/L)") +
  #ggtitle("Catch Per Unit Effort at Various Oxygen Concentrations") + 
  theme_minimal() +
  #scale_x_continuous(name="Oxygen Concentration (mL/L)", breaks=c(0,1,2,3,4,5,6)) +
  #scale_y_continuous(name="CPUE (kg/ha)", breaks=c(50, 100, 150, 200, 250, 300)) +
  theme(panel.grid.major = element_line(colour = "grey", size = 0.25),  #theme for bottom plot
        panel.grid.minor = element_line(colour = "grey", size = 0.25),
        axis.title.x= element_text(size =12,lineheight=3),
        axis.text.x= element_text(size =10),
        axis.text.y = element_text(size =10),
        axis.ticks.x=element_blank(),
        axis.title.y = element_text(size =12,lineheight=3)) 


ggplotly(CPlot)









