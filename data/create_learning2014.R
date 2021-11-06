
# Title: data wrangling for exercise 2
# Author:Liyuan E
# data: 05.11.2020

# Read the learning2014 data

Learn2014 <- read.table("https://www.mv.helsinki.fi/home/kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)

# The dimensions and structure of the learning2014

dim(Learn2014)
str(Learn2014)

# Combining questions variables related to deep, surface and strategic learning

library(dplyr)
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")

# combine the columns related to deep learning and create column 'deep' by averaging

deep_columns <- select(Learn2014, one_of(deep_questions))
Learn2014$Deep <- rowMeans(deep_columns)

# Combine the columns related to surface learning and create column 'surf' by averaging

surface_columns <- select(Learn2014, one_of(surface_questions))
Learn2014$Surf <- rowMeans(surface_columns)

# Combine the columns related to strategic learning and create column 'strategic' by averaging

strategic_columns <- select(Learn2014, one_of(strategic_questions))
Learn2014$Stra <- rowMeans(strategic_columns)

str(Learn2014)

# Assess the new column names 

colnames(Learn2014)

# keep the columns

new_columns <- c("gender","Age","Attitude", "Deep", "Stra", "Surf", "Points")

# create a new dataset by selecting the new_columns

learning2014 <- select(Learn2014, one_of(new_columns))

# Change gender into Gender

colnames(learning2014)[1] = "Gender"

# Exclude observations where the exam points variable is zero

learning2014 <- filter(learning2014, Points > 0)

# Look at the stucture of the new dataset

str(learning2014)

# Save the dataset

write.csv(learning2014, "learning2014.csv") 

# Read the new dataset

NewDataLrn14 <- read.csv("learning2014.csv")

#Look at the structure
str(NewDataLrn14)
