# This is Excercise 2 Analysis Script file
# Made byt Otto Mykkänen, University of Eastern Finland
# Date made 11.11.2019 
# 
# 1) Read data - used the website to be shure
#
#[Workspace loaded from ~/IODS-project/.RData]

#> library(readr)
#> learning2014 <- read_csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/learning2014.txt")
#Parsed with column specification:
  cols(
    gender = col_character(),
    age = col_double(),
    attitude = col_double(),
    deep = col_double(),
    stra = col_double(),
    surf = col_double(),
    points = col_double()
  )

#> View(learning2014)
str(learning2014)
dim(learning2014)

# looks fine 

#Description in short: This is a dataset used for learning purposes
# It has been modified from the original dataset to contain 7 variables with 166 subjects
# The data concerns study results of motivations and learning on statistics
# More info and metadata links found at https://www.mv.helsinki.fi/home/kvehkala/JYTmooc/JYTOPKYS3-meta.txt


#1)Show a graphical overview of the data and show summaries of the variables in the data.

#For this used the DataCamp runs on plotting data
#installed tidyverse to get ggplot2
# took awhile
#
library(ggplot2)
#now works with ggplot 2

p1 <- ggplot(learning2014, aes(x = attitude, y = points, col = gender))
p2 <- p1 + geom_point()
p3 <- p2 + geom_smooth(method = "lm")
p4 <- p3 + ggtitle("Student's attitude versus exam points")
p4


# looks nice with only minor changes related to gender, maybe males tend to
# be affected more by attiutude than females? 
# Most interestingly Female students got the highest points on exam
# and attiutude

#2) Show a graphical overview of the data and show summaries of the variables in the data.
#to do had to install >>> > install.packages("GGally")
# gain ggpairs to work 

p <- ggpairs(learning2014, mapping = aes(col = gender, alpha = 0.3), lower = list(combo = wrap("facethist", bins = 20)))
p

# this upper plot shows really nicely the distribution and spread of data
# Despite having slightly higher mean in age, attiutude in males the females get slightly better 
#scores in their approaches to the sudies surface, strategic. 

# 3)Choose three variables as explanatory variables and fit a regression model where exam points is the target (dependent) variable.
#
# tried single firs to see what are best. Thought verys simply age, attiutude and the strategic gives best model
# to single models plotted following
#
#
library(ggplot2)
qplot(age, points, data = learning2014) + geom_smooth(method = "lm")
qplot(attitude, points, data = learning2014) + geom_smooth(method = "lm")
qplot(stra, points, data = learning2014) + geom_smooth(method = "lm")
#since the age gave a high variation and was clearly clustered in spread groups
#with over or below 15 points I rather replace age by deep
qplot(deep, points, data = learning2014) + geom_smooth(method = "lm")

my_model1 <- lm(points ~ attitude, data = learning2014)
my_model2 <- lm(points ~ stra, data = learning2014)
my_model3 <- lm(points ~ deep, data = learning2014)
summary(my_model1)
summary(my_model2)
summary(my_model3)

# based on the single not combined models attiutude shows significance not others.
my_models1 <- lm(points ~ attitude + deep + stra, data = learning2014)
summary(my_models1)
# clearly the attiutude plays the most significant role here
# but the combined model also works!

#F-statistic: 14.33 on 3 and 162 DF,  p-value: 2.521e-08
#althought based on residuals the variation is high
#Min       1Q   Median       3Q      Max 
#-17.5239  -3.4276   0.5474   3.8220  11.5112 
#
# still significant (with 2 strars : )
#            Estimate Std. Error t value Pr(>|t|)    
#(Intercept)  11.3915     3.4077   3.343  0.00103 ** 
#
#Now. Based on the DataCamp exercise the best fitters are the following:
my_models2 <- lm(points ~ attitude + stra, data = learning2014)
summary(my_models2)
# and as espected it got a better significance.


# 4) the summaries were run in the above section so here 
#I will visualize the model which is question 5
par(mfrow = c(2,2))
plot(my_models2, which = c(1,2,5))
# based on plots (QQ-plot) the normality assumption is met weell.
#specially if the first quatile is filtered out : )

# constant variance assumption is lightly not met as there is 
#a cluster of data around the fitted values in 26 
# otherwise data looks ok

#the residuals vs leverage shows some outliers but mainly the model predicts well
