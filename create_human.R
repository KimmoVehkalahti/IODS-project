hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")
## this data vshows the human development index and gender equality. lets explore the structure and dimension of the data.
str(hd)
dim(hd)
str(gii)
dim(gii)
summary(hd)
summary(gii)

 ## lets create shorter names for the variable
names(hd) <- c("hdir", "cout","hdi", "birth", "edu", "Medu", "income", "capita")
str(hd)
names(gii) <- c("giir","cout","gii","mort", "birthR", "parl", "eduf","edum","labf","labm")
str(gii)
library(dplyr)
### lets mutate the data add new variables to the gender inequality data by taking the ratio of males and females in education and labour
gii <- mutate(gii, edu = eduf/edum)
str(gii)
gii <- mutate(gii, lab = labf/labm)
str(gii)
## join the two data set by using country as the modifier
join_by <- c("cout")
human<- inner_join(hd,gii, by = join_by)
dim(human)
library(openxlsx)
#setwd("/lara")
write.xlsx(human,file = "human.xlsx")
