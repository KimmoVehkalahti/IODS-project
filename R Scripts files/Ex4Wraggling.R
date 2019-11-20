#
# IODS Excercise 3 
#
# by Otto Mykkänen - University of Eastern Finland/ Savonia Code Academy 
#
# Created 13.11.2019 -
# 
# Dataset is from a study analysing secondary education level achievements in Portugese Schools.
# The two distinc datasets are representing mathematical (mat) or Portugese languange (por) perfomances.
#  
# Further discriptions and attributes: https://archive.ics.uci.edu/ml/datasets/Student+Performance
#
# libraries used in this data analyses

library(psych)
library(pastecs)
library(GGally)
library(ggplot2)
library(ggpubr)
library(dplyr)
library(tidyr)

library(MASS)


# Reading the data 
#install MASS pkg and load Boston dataset

# explorations

data("Boston")
class(Boston)
str(Boston)
summary(Boston)
boxplot(Boston)
cor_matrix<-cor(Boston) %>% round(digits = 2)
corrplot(cor_matrix, method="circle", type="upper", cl.pos="b", tl.pos="d", tl.cex = 0.6)

# center and standardize variables
boston_scaled <- scale(Boston)

# summaries of the scaled variables
summary(boston_scaled)

# class of the boston_scaled object
class(boston_scaled)

# change the object to data frame and verify class
boston_scaled<-as.data.frame(boston_scaled)
class(boston_scaled)

# number of rows in the Boston dataset 
n <- nrow(boston_scaled)

# choose randomly 80% of the rows
ind <- sample(n,  size = n * 0.8)

# create train set
train <- boston_scaled[ind,]

# create test set 
test <- boston_scaled[-ind,]

# save the correct classes from test data
correct_classes <- test$crime

# remove the crime variable from test data
test <- dplyr::select(test, -crime)





