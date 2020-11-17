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
# access the MASS package
library(MASS)
# load the data
data("Boston")
# explore the dataset
str(Boston)
'data.frame':	506 obs. of  14 variables:
 $ crim   : num  0.00632 0.02731 0.02729 0.03237 0.06905 ...
 $ zn     : num  18 0 0 0 0 0 12.5 12.5 12.5 12.5 ...
 $ indus  : num  2.31 7.07 7.07 2.18 2.18 2.18 7.87 7.87 7.87 7.87 ...
 $ chas   : int  0 0 0 0 0 0 0 0 0 0 ...
 $ nox    : num  0.538 0.469 0.469 0.458 0.458 0.458 0.524 0.524 0.524 0.524 ...
 $ rm     : num  6.58 6.42 7.18 7 7.15 ...
 $ age    : num  65.2 78.9 61.1 45.8 54.2 58.7 66.6 96.1 100 85.9 ...
 $ dis    : num  4.09 4.97 4.97 6.06 6.06 ...
 $ rad    : int  1 2 2 3 3 3 5 5 5 5 ...
 $ tax    : num  296 242 242 222 222 222 311 311 311 311 ...
 $ ptratio: num  15.3 17.8 17.8 18.7 18.7 18.7 15.2 15.2 15.2 15.2 ...
 $ black  : num  397 397 393 395 397 ...
 $ lstat  : num  4.98 9.14 4.03 2.94 5.33 ...
 $ medv   : num  24 21.6 34.7 33.4 36.2 28.7 22.9 27.1 16.5 18.9 ...
summary(Boston)
      crim                zn             indus            chas        
 Min.   : 0.00632   Min.   :  0.00   Min.   : 0.46   Min.   :0.00000  
 1st Qu.: 0.08204   1st Qu.:  0.00   1st Qu.: 5.19   1st Qu.:0.00000  
 Median : 0.25651   Median :  0.00   Median : 9.69   Median :0.00000  
 Mean   : 3.61352   Mean   : 11.36   Mean   :11.14   Mean   :0.06917  
 3rd Qu.: 3.67708   3rd Qu.: 12.50   3rd Qu.:18.10   3rd Qu.:0.00000  
 Max.   :88.97620   Max.   :100.00   Max.   :27.74   Max.   :1.00000  
      nox               rm             age              dis        
 Min.   :0.3850   Min.   :3.561   Min.   :  2.90   Min.   : 1.130  
 1st Qu.:0.4490   1st Qu.:5.886   1st Qu.: 45.02   1st Qu.: 2.100  
 Median :0.5380   Median :6.208   Median : 77.50   Median : 3.207  
 Mean   :0.5547   Mean   :6.285   Mean   : 68.57   Mean   : 3.795  
 3rd Qu.:0.6240   3rd Qu.:6.623   3rd Qu.: 94.08   3rd Qu.: 5.188  
 Max.   :0.8710   Max.   :8.780   Max.   :100.00   Max.   :12.127  
      rad              tax           ptratio          black       
 Min.   : 1.000   Min.   :187.0   Min.   :12.60   Min.   :  0.32  
 1st Qu.: 4.000   1st Qu.:279.0   1st Qu.:17.40   1st Qu.:375.38  
 Median : 5.000   Median :330.0   Median :19.05   Median :391.44  
 Mean   : 9.549   Mean   :408.2   Mean   :18.46   Mean   :356.67  
 3rd Qu.:24.000   3rd Qu.:666.0   3rd Qu.:20.20   3rd Qu.:396.23  
 Max.   :24.000   Max.   :711.0   Max.   :22.00   Max.   :396.90  
     lstat            medv      
 Min.   : 1.73   Min.   : 5.00  
 1st Qu.: 6.95   1st Qu.:17.02  
 Median :11.36   Median :21.20  
 Mean   :12.65   Mean   :22.53  
 3rd Qu.:16.95   3rd Qu.:25.00  
 Max.   :37.97   Max.   :50.00  
# plot matrix of the variables
pairs(Boston)
# MASS, corrplot, tidyr and Boston dataset are available

# calculate the correlation matrix and round it
cor_matrix<-cor(Boston) %>% round(digits = 2)

# print the correlation matrix
cor_matrix

# visualize the correlation matrix
corrplot(cor_matrix, method="circle", type="upper", cl.pos="b", tl.pos="d", tl.cex = 0.6)
# MASS, corrplot, tidyr and Boston dataset are available
# calculate the correlation matrix and round it
cor_matrix<-cor(Boston) %>% round(digits = 2)
# print the correlation matrix
cor_matrix
         crim    zn indus  chas   nox    rm   age   dis   rad   tax ptratio
crim     1.00 -0.20  0.41 -0.06  0.42 -0.22  0.35 -0.38  0.63  0.58    0.29
zn      -0.20  1.00 -0.53 -0.04 -0.52  0.31 -0.57  0.66 -0.31 -0.31   -0.39
indus    0.41 -0.53  1.00  0.06  0.76 -0.39  0.64 -0.71  0.60  0.72    0.38
chas    -0.06 -0.04  0.06  1.00  0.09  0.09  0.09 -0.10 -0.01 -0.04   -0.12
nox      0.42 -0.52  0.76  0.09  1.00 -0.30  0.73 -0.77  0.61  0.67    0.19
rm      -0.22  0.31 -0.39  0.09 -0.30  1.00 -0.24  0.21 -0.21 -0.29   -0.36
age      0.35 -0.57  0.64  0.09  0.73 -0.24  1.00 -0.75  0.46  0.51    0.26
dis     -0.38  0.66 -0.71 -0.10 -0.77  0.21 -0.75  1.00 -0.49 -0.53   -0.23
rad      0.63 -0.31  0.60 -0.01  0.61 -0.21  0.46 -0.49  1.00  0.91    0.46
tax      0.58 -0.31  0.72 -0.04  0.67 -0.29  0.51 -0.53  0.91  1.00    0.46
ptratio  0.29 -0.39  0.38 -0.12  0.19 -0.36  0.26 -0.23  0.46  0.46    1.00
black   -0.39  0.18 -0.36  0.05 -0.38  0.13 -0.27  0.29 -0.44 -0.44   -0.18
lstat    0.46 -0.41  0.60 -0.05  0.59 -0.61  0.60 -0.50  0.49  0.54    0.37
medv    -0.39  0.36 -0.48  0.18 -0.43  0.70 -0.38  0.25 -0.38 -0.47   -0.51
        black lstat  medv
crim    -0.39  0.46 -0.39
zn       0.18 -0.41  0.36
indus   -0.36  0.60 -0.48
chas     0.05 -0.05  0.18
nox     -0.38  0.59 -0.43
rm       0.13 -0.61  0.70
age     -0.27  0.60 -0.38
dis      0.29 -0.50  0.25
rad     -0.44  0.49 -0.38
tax     -0.44  0.54 -0.47
ptratio -0.18  0.37 -0.51
black    1.00 -0.37  0.33
lstat   -0.37  1.00 -0.74
medv     0.33 -0.74  1.00
# visualize the correlation matrix
corrplot(cor_matrix, method="circle", type="upper", cl.pos="b", tl.pos="d", tl.cex = 0.6)
