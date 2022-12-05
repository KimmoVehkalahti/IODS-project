#Name: Subam Kathet
#Date: 05 December 2022

#IODS Exercise set 5 - Dimensionality reduction techniques
#R-learning codes for week 5 data wrangling exercises 

#We will be working with the same human data wrangled during last weeks exercise session
#The csv file was saved in the project folder

#Human data originates from United Nations Developement Program
#Link: https://hdr.undp.org/data-center/human-development-index#/indicies/HDI  

#Overview of the data
      ##calculating the human developement indices-graphical presentation
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
summary(human$GNI)
print(human$GNI)

##Step 3## Exclude unneded variables
#keep only the columns matching the following variable names (described in the meta file above): 
#"Country", "Edu2.FM", "Labo.FM", "Edu.Exp", "Life.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F"

##Step 4## Remove all rows with missing values

##Step 5## Remove the observations which relate to regions instead of countries

##Step 6## Define data
#Define the row names of the data by the country names and remove the country name column from the data

##Step 7## SAve the file

#Data wrangling complete !! lets move on to the analysis 


