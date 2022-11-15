#Name: Subam Kathet 
#Date: 14 November 2022
#Description: R codes for exercise set 2 for IODS course

library(dplyr)
library(tidyverse)
library(GGally)
library(ggplot2)

# Use read.tabe to import the data set into R through the link

lrn14 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)

#use .txt file to import data set for better description.
# Preliminary results available at http://www.slideshare.net/kimmovehkalahti/the-relationship-between-learning-approaches-and-students-achievements-in-an-introductory-statistics-course-in-finland
#Total respondents n=183, total question n=60, so 184 rows including heading and 60 columns
#The data set is basically outomes of international survey on approaches to learning conducted from the social science department of university of helinki.
#The code as respective column heading represents a question related to the survey and number. Each SN is a respondents and the answers to each question are given in a Lickert scale (0-5).

#Print the data set

print(dim(lrn14))
print(class(lrn14))
print(str(lrn14))

# Week 2: Regression and model validation

# 2.1 Reading data from the web

lrn14 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-meta.txt", sep="\t", header=TRUE)

# Look at the dimensions of the data

# Look at the structure of the data
#use .txt file to import data set for better description.
# Preliminary results available at http://www.slideshare.net/kimmovehkalahti/the-relationship-between-learning-approaches-and-students-achievements-in-an-introductory-statistics-course-in-finland
#Total respondents n=183, total question n=60, so 184 rows including heading and 60 columns
#The code as respective column heading represents a question related to the survey and number. Each SN is a respondents and the answers to each question are given in a Lickert scale (0-5).

dim(lrn14)
str(lrn14)

## 2.2 Scaling variables

#The next step is [wrangling the data](https://en.wikipedia.org/wiki/Data_wrangling) into a format that is easy to analyze. We will wrangle our data for the next few exercises. 
#A neat thing about R is that may operations are *vectorized*. It means that a single operation can affect all elements of a vector. This is often convenient.
#The column `Attitude` in `lrn14` is a sum of 10 questions related to students attitude towards statistics, each measured on the [Likert scale](https://en.wikipedia.org/wiki/Likert_scale) (1-5). Here we'll scale the combination variable back to the 1-5 scale.

lrn14$attitude <- lrn14$Attitude / 10

## 2.3 Combining variables

# questions related to deep, surface and strategic learning
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")

# select the columns related to deep learning 
deep_columns <- select(lrn14, one_of(deep_questions))
# and create column 'deep' by averaging
lrn14$deep <- rowMeans(deep_columns)

# select the columns related to surface learning 
surface_columns <- select(lrn14, one_of(surface_questions))
# and create column 'surf' by averaging
lrn14$surf <- rowMeans(surface_columns)

# select the columns related to strategic learning 
strategic_columns <- select(lrn14, one_of(strategic_questions))
# and create column 'stra' by averaging
lrn14$stra <- rowMeans(strategic_columns)

## 2.4 Selecting columns

library(dplyr)

# choose a handful of columns to keep
keep_columns <- c("gender","Age","attitude", "deep", "stra", "surf", "Points")

# select the 'keep_columns' to create a new dataset
learning2014 <- select(lrn14,all_of(keep_columns))

# see the structure of the new dataset

print(learning2014)

## 2.5 Modifying column names

print(names(learning2014))
colnames(learning2014)[2] <- "age"
learning2014 <- rename(learning2014, points = Points)
print(dim(learning2014)) #check the dimension now (must have 166 rown and 7)

## 2.6 Excluding observations

learning2014 <- learning2014[learning2014$points > 0,]
dim(lrn14)
dim(learning2014)

#Export csv file
setwd("~/Documents/GitHub/IODS-project")
write_csv(learning2014, 'learning2014.csv')






