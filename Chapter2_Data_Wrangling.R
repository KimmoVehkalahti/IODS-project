#Chapter 2: Regression and model validation

#Data wrangling (max 5 points)

#reading txt table from URL:
myfile <- read.table(url("https://www.mv.helsinki.fi/home/kvehkala/JYTmooc/JYTOPKYS2-data.txt"), sep = "\t", header = TRUE)
#dimensions of the table
dim(myfile)
#table has 183 rows and 97 columns (variables)
colnames(myfile)
rownames(myfile)
#column names and row names listed

#Create an analysis dataset with the variables 
#Gender, Age, Attitude, Deep, Stra, Surf and Points
a <- subset(myfile, select=c(Gender,Age,Attitude, Deep, Stra, Surf, Points))
dim(a)

#Combination Variables are Attitude, Deep, Stra and Surf are scaled to mean
aa <- scale(a[,3:6],center=TRUE, scale=FALSE)
a[,3:6] <- aa
dim(a)

#Deleting rows where Points=0
azero <- a[a$Points != 0,]
dim(azero)
#166 rows with 7 variables
library(tidyverse)
write_csv(x=azero, 'learning2014.csv', col_names = TRUE)
azeronew <- read_csv("learning2014.csv")
#table saved as csv-file, also able to open