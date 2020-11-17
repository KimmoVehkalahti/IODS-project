# IODS-project
Template for the IODS course
https://github.com/sanaakadi/IODS-projechttps-github.com-sanaakadi-IODS-project-settingst
# learning2014 is available

# print out the column names of the data
colnames(learning2014)

# change the name of the second column
colnames(learning2014)[2] <- "age"

# change the name of "Points" to "points"
colnames(learning2014)[7] <- "points"

# print out the new column names of the data
colnames(learning2014)
# read the data into memory
lrn14 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)

# Look at the dimensions of the data
dim(lrn14)

# Look at the structure of the data
str(lrn14)
# learning2014 is available

# access the dplyr library
library(dplyr)

# select male students
male_students <- filter(learning2014, gender == "M")

# select rows where Points is greater than zero
learning2014 <- filter(learning2014, points > 0)
# learning2014 is available

# Use the gglot2 library
library(ggplot2)

# initialize plot with data and aesthetic mapping
p1 <- ggplot(learning2014, aes(x = attitude, y = points, col = gender))

# define the visualization type (points)
p2 <- p1 + geom_point()

# draw the plot
p2

# add a regression line
p3 <- p2 + geom_smooth(method = "lm")

# add a main title and draw the plot
p4 <- p3 + ggtitle("Student's attitude versus exam points")
p4
# learning2014 is available

# draw a scatter plot matrix of the variables in learning2014.
# [-1] excludes the first column (gender)
pairs(learning2014[-1], col = learning2014$gender)

# access the GGally and ggplot2 libraries
library(GGally)
library(ggplot2)

# create a more advanced plot matrix with ggpairs()
p <- ggpairs(learning2014, mapping = aes(col = gender, alpha = 0.3), lower = list(combo = wrap("facethist", bins = 20)))

# draw the plot
p
# learning2014 is available

# a scatter plot of points versus attitude
library(ggplot2)
qplot(attitude, points, data = learning2014) + geom_smooth(method = "lm")

# fit a linear model
my_model <- lm(points ~ attitude, data = learning2014)

# print out a summary of the model
summary(my_model)
# learning2014, GGally, ggplot2 are available

# create an plot matrix with ggpairs()
ggpairs(learning2014, lower = list(combo = wrap("facethist", bins = 20)))

# create a regression model with multiple explanatory variables
my_model2 <- lm(points ~ attitude + stra + surf, data = learning2014)

# print out a summary of the model
summary(my_model2)
