# Read the data
human <- read.table("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F, sep =",", header = T)
Gender <- read.table("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..", sep =",", header = T)

# See the structure and dimension of the data 
str(human)
dim(human)
str(Gender)
dim(Gender)

# rename the varaibles
colnames(human)
colnames(human)[3] <- "HDI." 
colnames(human)[4] <- "Birth" 
colnames(human)[5] <- "EEducation" 
colnames(human)[6] <- "MEducation" 
colnames(human)[7] <- "GNI." 

# Mutate
library(dplyr)
Gender <- mutate(Gender, edu2F / edu2M = ratio of Female and Male populations with secondary education in each country)
Gender <- mutate(Gender, i.e. labF / labM = ratio of labour force participation of females and males in each country)

# Join together the two datasets using the variable Country as the identifier
join_by <- c("Country")
human_Gender <- inner_join(human, Gender, by = join_by, suffix = c(".human", ".Gender"))
colnames(human_Gender)
glimpse(human_Gender)
dim(human_Gender)
human <- inner_join(human, Gender, by = join_by, suffix = c(".human", ".Gender"))
dim(human)