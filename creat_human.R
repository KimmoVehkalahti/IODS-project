
#Name: Subam Kathet

#Date: 27/11/2022

#Introduction to open data science

#Week 4: Clustering and Classification

#This weeks learning tasks includes exercises from week 4 - clustering and classification 

# Data resource: https://archive.ics.uci.edu/ml/machine-learning-databases/00320/
# Data files:
## human_development.csv
## gender_inequality.csv
# More information can be fould below:
## https://hdr.undp.org/data-center/human-development-index#/indicies/HDI
## https://hdr.undp.org/system/files/documents//technical-notes-calculating-human-development-indices.pdf
# Meta files:
## https://github.com/KimmoVehkalahti/Helsinki-Open-Data-Science/blob/master/datasets/human_meta.txt

## Required packages
library(tidyverse)
library(dplyr)
library(ggplot2)

# Step 1
# read data
hd <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/human_development.csv")
gii <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/gender_inequality.csv", na = "..")


# Step 2
# See structure and dimentions of the data
str(hd);dim(hd)
str(gii);dim(gii)

# Summaries of the variables
summary(hd)
summary(gii)


# Step 3
# Rename variables with shorter names (see Meta files)
# Percent Representation in parliament is % of women (see HDI technical notes)
hd2 <- hd %>% rename(
  'HDI_rank' = 'HDI Rank',
  'HDI' = 'Human Development Index (HDI)',
  'Life.Exp' = 'Life Expectancy at Birth',
  'Edu.Exp' = 'Expected Years of Education',
  'Edu.Mean' = 'Mean Years of Education',
  'GNI' = 'Gross National Income (GNI) per Capita',
  'GNI.minus.HDI_rank' = 'GNI per Capita Rank Minus HDI Rank'
)

gii2 <- gii %>% rename(
  'GII_rank'= 'GII Rank',
  'GII' = 'Gender Inequality Index (GII)',
  'Mat.Mor' = 'Maternal Mortality Ratio',
  'Ado.Birth' = 'Adolescent Birth Rate',
  'Parli.F' = 'Percent Representation in Parliament',
  'Edu2.F' = 'Population with Secondary Education (Female)',
  'Edu2.M' = 'Population with Secondary Education (Male)',
  'Labo.F' = 'Labour Force Participation Rate (Female)',
  'Labo.M' = 'Labour Force Participation Rate (Male)'
)

# Step 4
# Add new variables edu2F / edu2M and labF / labM

gii2 <- mutate(gii2, Edu2.FM=Edu2.F/Edu2.M,
               Labo.FM=Labo.F/Labo.M)


# Step 5
# Join the two dataset by Country. Keep only those with both datasets (innerjoin())
human <- inner_join(hd2, gii2, by='Country')
dim(human)

#save new dataset to data folder
#write_csv(human, file="human.csv")

#check to see if its ok 
read_csv("human.csv")
dim("human.csv")
str("human.csv")

# Everything looks fine ! 

#Data wrangling complete, All set for analyses !!! 
