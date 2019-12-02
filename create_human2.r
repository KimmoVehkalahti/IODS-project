#Omolara Mofikoya
## this data shows the human development index and gender equality
## the original file can be found in http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human1.txt
human <- readxl::read_excel("~/IODS-project/human.xlsx")
#structure and dimension of the data
str(human)
dim(human)
names(human)
# access the stringr package
library(stringr)
str(human$income)
human$income <- str_replace(human$income, pattern=",", replace ="") 
human$income <-str_replace(human$income, pattern=",", replace ="") %>% as.numeric
# columns to keep
keep <- c("cout", "edu.y", "lab", "birth", "edu.x", "income", "mort", "birthR", "parl")
human <- select(human, one_of(keep))
dim(human)
str(human)
#Remove all rows with missing values
complete.cases(human)
human_ <- filter(human, complete.cases(human))
# Remove observation relating to region
last <- nrow(human_) - 7
human_ <- human_[1:last, ]
dim(human_)
# Define the row names of the data by the country names and remove the country name column from the data. 
rownames(human_) <- human_$cout
human_ <- human_[,-1]
#human_ <- select(human_,-cout)
dim(human_)
str(human_)
library(openxlsx)
#setwd("/lara")
write.xlsx(human_,file = "human_.xlsx")
