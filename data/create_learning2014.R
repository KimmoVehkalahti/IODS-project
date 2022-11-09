#Rong Guang
#8/11/2022
#Data wrangling task in assignment 2.


#1 import data to object "learn"  
learn <- 
  read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", 
             sep="\t", 
             header=TRUE)

##1.1 check the dimensions of learn
dim(learn)
##finding: data frame "learn" contains 183 observations of 60 variables.

##1.2 check the structure of learn
str(learn)
##finding: "learn" is a data frame. It has 59 numeric variables (integer 
##sub-type), among which 56 are with values ranging from one to five. There is 
##one character variable, which has dichotomous values of F and M. 


#2 Create an analysis dataset with the variables gender, age, attitude, deep, 
#stra, surf and points

##2.1 create column 'attitude' by scaling the column "Attitude"
learn$attitude <- learn$Attitude / 10

##2.2 create column 'deep' by taking the mean of deep-related items.
deep_questions <- c("D03", 
                    "D11", 
                    "D19", 
                    "D27", 
                    "D07", 
                    "D14", 
                    "D22", 
                    "D30",
                    "D06",  
                    "D15", 
                    "D23", 
                    "D31")
learn$deep <- rowMeans(lrn14[, deep_questions])

##2.3 create column 'surf' by taking the mean of surface_questions-related items.
surface_questions <- c("SU02",
                       "SU10",
                       "SU18",
                       "SU26", 
                       "SU05",
                       "SU13",
                       "SU21",
                       "SU29",
                       "SU08",
                       "SU16",
                       "SU24",
                       "SU32")
learn$surf <- rowMeans(lrn14[, surface_questions])

##2.4 create column 'stra' by taking the mean of strategic_questions-related items.
strategic_questions <- c("ST01",
                         "ST09",
                         "ST17",
                         "ST25",
                         "ST04",
                         "ST12",
                         "ST20",
                         "ST28")
learn$stra <- rowMeans(lrn14[, strategic_questions])

##2.5 combine new variables into dataset for analysis
learn <- learn[, c("gender",
                   "Age",
                   "attitude", 
                   "deep", 
                   "stra", 
                   "surf", 
                   "Points")]

##2.6 Exclude observations where the exam points variable is zero
learn <- filter(learn, Points != 0)

##2.7 Check if the number of observations reduced to 166
dim(learn)

##2.8 Fine-tune variable names to get better consistency
###2.8.1 rename "Age" to "age"
colnames(learning2014)[which(colnames(learn) == "Age")] <- "age"
###2.8.2 rename "Points" to "point"
colnames(learning2014)[which(colnames(learn) == "Points")] <- "points"

#3 Save analysis data set

library(tidyverse)

##3.1 set working directory
setwd("/Users/rongguang/Documents/IODS-project")

##3.2 save to data folder
write_csv(learn, file ="data/learning2014.csv")

##3.3 read the data set
learn.read <- read_csv("data/learning2014.csv")

##3.4 check the data set 
###3.4.1 check structure
str(learn.read)
###3.4.2 check the first 20 observations
head(learn.read, 20)
















