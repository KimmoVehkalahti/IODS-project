#
# IODS Excercise 5 - Data Wrangling
#
# by Otto Mykkänen - University of Eastern Finland/ Savonia Code Academy 
#
# Created 16.11.2019 - 17.11.2019
# 
# Dataset consist of two Human development and Gender inequality files.
# Has 195 obeservations and 19 variables
# The metadata for them can be located:https://raw.githubusercontent.com/TuomoNieminen/Helsinki-Open-Data-Science/master/datasets/human_meta.txt
#  
# other links for recources: http://hdr.undp.org/en/content/human-development-index-hdi
#   http://hdr.undp.org/sites/default/files/hdr2015_technical_notes.pdf
#
# 
#Load packages... 
library(psych)
library(pastecs)
library(tidyr)
library(dplyr)
library(GGally)
library(ggpubr)
library(ggplot2)
library(skimr)
library(DataExplorer)
library(stringr)
library(corrplot)

# Read data

human <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human1.txt", sep  =",", header = T)
dim(human)


#Mutate the data (#1)

str(human$GNI)
str_replace(human$gni, pattern=",", replace ="") %>% as.numeric

#Exclude the unneeded variables (#2)

keep <- c("Country", "Edu2.FM", "Labo.FM", "Life.Exp", "Edu.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F")
human <- dplyr::select(human, one_of(keep))
dim(human)

#Remove all rows with missing values (#3)

complete.cases(human)
data.frame(human[-1], comp = complete.cases(human))
human_ <- filter(human, complete.cases(human))
dim(human_)

#Remove observations not relating to countries (#4)

tail(human_, 10)
last <- nrow(human_) - 7
human_ <- human[1:last, ]
dim(human_)

#Define the row names of the data by the country names (#5)

rownames(human_) <- human_$Country
human_ <- human_[-1]
dim(human_)
colnames(human_)

#save & exit

write.csv(human_, file = "humandata.csv", row.names = TRUE)


  
  
