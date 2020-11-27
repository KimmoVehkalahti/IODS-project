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



# Load the 'human' data (Continue the data wrangling last week)

human_Gender <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human2.txt", stringsAsFactors = F)

# Exploring the structure and dimension of the data (My name: Liyuan E; Description: the dimension of the dataset showed that it has 195 observations and 19 variables; the structure of the dataset showed the 19 variables is as following: hdi_rank, country, hdi, life_exp, exp_edu, mean_edu, gni, gni_minus_hdi, gii, mat_mortality, adol_birth, parl_seats,f_2edu, m_2edu, f_lab, m_lab, edu2FMratio and lab2FMratio)


str(human_Gender)
dim(human_Gender)

# Mutate the data

library(stringr)
str(human_Gender$gni)
str_replace(human_Gender$GNI, pattern=",", replace ="") %>% as.numeric

# Exclude unneeded variables

keep <- c("country", "edu2FMratio", "lab2FMratio", "life_exp", "exp_edu", "gni", "mat_mortality", "adol_birth", "parl_seats")
library(dplyr)
human_Gender <- dplyr::select(human_Gender, one_of(keep))

# remove all rows with missing values

complete.cases(human_Gender)
human_Gender_ <- filter(human_Gender, complete.cases(human_Gender))

# remove the observations regards regions instead of countries (have to change the name that has to be same above)

tail(human_Gender, 10)
last <- nrow(human_Gender) - 7
human_Gender_ <- human[1:last, ]

# define the row names of the data by the country names and remove the country name column

rownames(human_Gender_) <- human_Gender$country 
human_Gender_ <- dplyr::select(human_Gender, - country)

# save the data
write.csv(human_Gender_,file="data/human.csv", row.names = F)