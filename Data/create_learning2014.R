#Omolara Mofikoya 11.11.2011 second exercise in IODS



#read the data into R
lrn14 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)

#look at the structure of the data
str(lrn14)

#look at the dimension of the data
dim(lrn14)

#define structure of data
summary(lrn14)

# install.packages("dplyr")
library(dplyr)

# questions related to deep, surface and strategic learning
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")

# select the columns related to deep learning, surface andstrategic learning
deep_columns <- select(lrn14, one_of(deep_questions))
surface_columns <- select(lrn14, one_of(surface_questions))
strategic_columns <- select(lrn14, one_of(strategic_questions))

# Create column 'attitude' by scaling the column "Attitude"
# Create columns 'deep', 'surf', and 'stra' by averaging
# Exclude observations where the exam point variable is zero
# Select variables gender, age, attitude, deep, stra, surf and points

# create columns 'deep', 'surf', and 'stra' by averaging
lrn14$deep <- rowMeans(deep_columns)
lrn14$surf <- rowMeans(surface_columns)
lrn14$stra <- rowMeans(strategic_columns)

# create column 'attitude' by scaling the column "Attitude"
lrn14$attitude <- lrn14$Attitude / 10


keep_columns <- c("gender","Age","attitude", "deep", "stra", "surf", "Points")
learning2014 <- select(lrn14, one_of(keep_columns))
filter(learning2014, Points!= 0)
str(learning2014)
head(learning2014)
library(openxlsx)
#setwd("/lara")
write.xlsx(learning2014,"learnings2014.xlsx")


  

  
  
  