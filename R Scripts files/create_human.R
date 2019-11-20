#
# IODS Excercise 4 - Data Wrangling
#
# by Otto Mykkänen - University of Eastern Finland/ Savonia Code Academy 
#
# Created 16.11.2019 - 17.11.2019
# 
# Dataset consist of two “Human development” and “Gender inequality”.
# The metadata for them can be located:
#  
# Metalinks: http://hdr.undp.org/en/content/human-development-index-hdi
#            http://hdr.undp.org/sites/default/files/hdr2015_technical_notes.pdf
# 
#
# 
#
# 
#

# Reading the data

hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
por <- read.csv("~/IODS-project/data/student-por.csv", sep=";")

#creating summaries of each dataset (3#)
class(hd)
dim(hd)
head(hd)
str(hd)
summary(hd)
colnames(hd)

class(hd)
dim(gii)
head(gii)
str(gii)
summary(gii)
colnames(gii)


# For renaming take a look first (#4)

colnames(hd)
colnames(gii)


# Renaming all variabels (colnames)


hd = rename(hd, "hdi_rank" = "HDI.Rank", "country" = "Country", "hdi" = "Human.Development.Index..HDI.", "Life.Exp"  = "Life.Expectancy.at.Birth","Edu.Exp" =  "Expected.Years.of.Education" , "edu_mean" = "Mean.Years.of.Education" , "GNI" = "Gross.National.Income..GNI..per.Capita", "gnirank_hdirank" = "GNI.per.Capita.Rank.Minus.HDI.Rank")

gii = rename(gii, "gii_rank" = "GII.Rank", "country" = "Country" , "gii" = "Gender.Inequality.Index..GII." , "Mat.Mor"  = "Maternal.Mortality.Ratio", "Ado.Birth" =  "Adolescent.Birth.Rate" , "Parli.F" = "Percent.Representation.in.Parliament" , "Edu2.F" = "Population.with.Secondary.Education..Female.", "Edu2.M" = "Population.with.Secondary.Education..Male.", "Labo.F" = "Labour.Force.Participation.Rate..Female.", "Labo.M" = "Labour.Force.Participation.Rate..Male.")

# Little cleaning the commas off so not to confuse R with this data (just an extra step)

str(hd$gni)
str_replace(hd$gni, pattern=",", replace ="") %>% as.numeric

# Mutate to create 2 new variables (#5)

mutate(gii, Edu2.FM = Edu2.F / Edu2.M)
mutate(gii, Labo2.FM = Labo.F / Labo.M)


# Join the two datasets using Country as id.(#6) 

join_by <- c("country")
human <- inner_join(hd, gii, by = join_by, suffix = c("hd", "gii"))

str(human)

# note! the two mutated new variables seemingly did not like to join the dataset??
# desided to use the link provided

human <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human1.txt",  stringsAsFactors = F)
dim(human)

# taking off commas 
str(human$gni)
str_replace(human$gni, pattern=",", replace ="") %>% as.numeric

# columns to keep
keep <- c("Country", "Edu2.FM", "Labo.FM", "Life.Exp", "Edu.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F")
human <- select(human, one_of(keep))

# removing missing values
complete.cases(human)
data.frame(human[-1], comp = complete.cases(human))
human_ <- filter(human, complete.cases(human))
dim(human_)

#removing obs from non country
tail(human_, 10)
last <- nrow(human_) - 7
human_ <- human[1:last, ]
dim(human_)

#defining the row names of the data by the country names
rownames(human_) <- human_$Country
human_ <- human_[-1]
dim(human_)
colnames(human_)

#saving file
write.csv(human_, file = "humandata.csv", row.names = TRUE)




# Overview and blotting the data

human <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human2.txt", header = TRUE, sep = ",")
head(human)
summary(human)
ggpairs(human)
cor(human) %>% corrplot

#ANALYSIS

#PCA of non-standardized data

pca_human1 <- prcomp(human)
s1 <- summary(pca_human1)
#rounding to prencentages
pca_pr1 <- round(100*s1$importance[2,], digits = 1) 
pca_pr1
pc_lab1 <- paste0(names(pca_pr1), " (", pca_pr1, "%)")
biplot(pca_human1, cex = c(0.8, 1), col = c("grey40", "deeppink2"), xlab = pc_lab1[1], ylab = pc_lab1[2])


#PCA of standardized data

human_std <- scale(human)
pca_human2 <- prcomp(human_std)
s2 <- summary(pca_human2)
#roubding to precentages
pca_pr2 <- round(100*s2$importance[2,], digits = 1) 
pca_pr2
pc_lab2 <- paste0(names(pca_pr2), " (", pca_pr2, "%)")
biplot(pca_human2, cex = c(0.8, 1), col = c("grey40", "deeppink2"), xlab = pc_lab2[1], ylab = pc_lab2[2])













#The Analysis task (#5)


install.packages("FactoMineR")
library(FactoMiner)

