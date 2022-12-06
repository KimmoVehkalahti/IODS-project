#Name: Subam Kathet
#Date: 05 December 2022

#IODS Exercise set 5 - Dimensionality reduction techniques
#R-learning codes for week 5 data wrangling exercises 

#We will be working with the same human data wrangled during last weeks exercise session
#The csv file was saved in the project folder

#Human data originates from United Nations Development Program
#Link: https://hdr.undp.org/data-center/human-development-index#/indicies/HDI  

#Overview of the data
      ##calculating the human development indices-graphical presentation
      # https://hdr.undp.org/system/files/documents//technical-notes-calculating-human-development-indices.pdf

#Lets start the data wrangling exercise

#packages
library(tidyverse)
library(dplyr)
library(ggplot2)

##Step 1## Importing data set into R
#Lets import last week's csv file
human <- read_csv("human.csv")
dim("human")
str("human")
summary("human")
#195 observation and 19 variables, looks great !! 

##Step 2## Mutate the data
#Transform the Gross National Income (GNI) variable to numeric (using string manipulation)

library(stringr)
str(human$GNI)
str_replace(human$GNI, pattern=",", replace ="") %>% as.numeric

#Check data now
summary(human$GNI)
print(human$GNI)

##Step 3## Exclude unneeded variables
#keep only the columns matching the following variable names

library(dplyr)
# columns to keep
keep <- c("Country", "SeEdu_FM", "LFR_FM", "Life_Exp", "Exp_Edu", "GNI", "MMR", "ABR", "%PR")
human <- select(human, one_of(keep))
include <- complete.cases(human)


#Lets see now
str(human); dim(human)
#195 observation and 8 variables, great !! lets continue


##Step 4## Remove all rows with missing values  

data.frame(human[-1], comp = include)

human_ <- filter(human, include)

rownames(human_) <- human_$Country

##Step 5## Remove the observations which relate to regions instead of countries

tail(human_, n = 10)
last <- nrow(human_) - 7
human_ <- human_[1:last, ]

##Step 6## #Define the row names of the data by the country names and remove the country name column from the data
human_
human_$GNI <- gsub(",", "", human_$GNI) %>% as.numeric
str(human_);dim(human_)

#155 observations and 7 variables, great !! 

##Step 7## Save the file
#save new data set to project folder
write.csv(human_, file="human_.csv")

#check
read.csv('human_.csv', row.names = 1)

#Data wrangling complete !! lets move on to the analysis 


