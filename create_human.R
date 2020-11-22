# Read the data
Human <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
Gender <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

# See the structure and dimension of the data 
str(Human)
dim(Human)
str(Gender)
dim(Gender)

# rename the varaibles
names(Human)
names(Human) <- c('hdi_rank', 'country', 'hdi', 'life_exp', 'exp_edu', 'mean_edu', 'gni', 'gni_minus_hdi')
names(Human)

names(Gender)
names(Gender) <- c('gii_rank','country','gii','mat_mortality', 'adol_birth', 'parl_seats',
'f_2edu', 'm_2edu', 'f_lab', 'm_lab' )
names(Gender)

# Mutate
library(dplyr)
Gender <- Gender %>% mutate(edu2FMratio = f_2edu/m_2edu)
Gender <- Gender %>% mutate(lab2FMratio = f_lab/m_lab)
glimpse (Gender)


# Join together the two datasets using the variable Country as the identifier
join_by <- c("country")
human_Gender <- inner_join(Human, Gender, by = join_by, suffix = c(".Human", ".Gender"))
colnames(human_Gender)
glimpse(human_Gender)
dim(human_Gender)

#save the data
write.csv(human,file="data/human.csv", row.names = F)