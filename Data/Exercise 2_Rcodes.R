#Name: Subam Kathet 
#Date: 14 November 2022
#Description: R codes and some notes for exercise set 2 for IODS course

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

## 2.7 Visualizations with ggplot2

#[**ggplot2**](http://ggplot2.org/) is a popular library for creating stunning graphics with R. It has some advantages over the basic plotting system in R, mainly consistent use of function arguments and flexible plot alteration. ggplot2 is an implementation of Leland Wilkinson's *Grammar of Graphics* — a general scheme for data visualization.

#In ggplot2, plots may be created via the convenience function `qplot()` where arguments and defaults are meant to be similar to base R's `plot()` function. More complex plotting capacity is available via `ggplot()`, which exposes the user to more explicit elements of the grammar. (from [wikipedia](https://en.wikipedia.org/wiki/Ggplot2))

#RStudio has a [cheatsheet](https://www.rstudio.com/resources/cheatsheets/) for data visualization with ggplot2.

# initialize plot with data and aesthetic mapping
p1 <- ggplot(learning2014, aes(x = attitude, y = points))

# define the visualization type (points)
p2 <- p1 + geom_point()

# draw the plot
p2

# add a regression line
p3 <- p2 + geom_smooth(method = "lm")

# draw the plot
p3

#Lets try and overview summary
p <- ggpairs(learning2014, mapping = aes(col = gender, alpha = 0.3), lower = list(combo = wrap("facethist", bins = 20)))
# draw the plot!
p


## 2.8 Exploring a data frame

#Often the most interesting feature of your data are the relationships between the variables. If there are only a handful of variables saved as columns in a data frame, it is possible to visualize all of these relationships neatly in a single plot.

#Base R offers a fast plotting function `pairs()`, which draws all possible scatter plots from the columns of a data frame, resulting in a scatter plot matrix. Libraries **GGally** and **ggplot2** together offer a slow but more detailed look at the variables, their distributions and relationships.


### R code

# Work with the exercise in this chunk, step-by-step. Fix the R code!
# learning2014 is available

# draw a scatter plot matrix of the variables in learning2014.
# [-1] excludes the first column (gender)
pairs(learning2014[-1])

# access the GGally and ggplot2 libraries
library(GGally)
library(ggplot2)

# create a more advanced plot matrix with ggpairs()
p <- ggpairs(learning2014, mapping = aes(), lower = list(combo = wrap("facethist", bins = 20)))

## 2.9 Simple regression


# Work with the exercise in this chunk, step-by-step. Fix the R code!
# learning2014 is available

# a scatter plot of points versus attitude
library(ggplot2)
qplot(attitude, points, data = learning2014) + geom_smooth(method = "lm")

# fit a linear model
my_model <- lm(points ~ 1, data = learning2014)

# print out a summary of the model
summary(my_model)

## 2.10 Multiple regression
# Work with the exercise in this chunk, step-by-step. Fix the R code!
# learning2014 is available

# create an plot matrix with ggpairs()
ggpairs(learning2014, lower = list(combo = wrap("facethist", bins = 20)))

# create a regression model with multiple explanatory variables
my_model2 <- lm(points ~ attitude + stra, data = learning2014)

# print out a summary of the model
summary(my_model2)

## 2.11 Graphical model validation
# Work with the exercise in this chunk, step-by-step. Fix the R code!
# learning2014 is available

# create a regression model with multiple explanatory variables
my_model2 <- lm(points ~ attitude + stra, data = learning2014)

# draw diagnostic plots using the plot() function. Choose the plots 1, 2 and 5
plot(my_model2, which = 1)

plot(my_model2, which = 2)

plot(my_model2, which = 3)

plot(my_model2, which = 4)

plot(my_model2, which = 5)

plot(my_model2, which = 6)

## 2.12 Making predictions

# Create model object m
m <- lm(points ~ attitude, data = learning2014)

# print out a summary of the model
summary(m)

# New observations
new_attitudes <- c("Mia" = 3.8, "Mike"= 4.4, "Riikka" = 2.2, "Pekka" = 2.9)
new_data <- data.frame(attitude = new_attitudes)

# Print out the new data
summary(new_data)

# Predict the new students exam points based on attitude
predict(m, newdata = new_data)







