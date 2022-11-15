#Rong Guang
#14/11/2022

# 1 Read both student-mat.csv and student-por.csv into R (from the data folder) 
# and explore the structure and dimensions of the data.

## 1.1 prepare packages and data sets
library(tidyverse)#read relevant package
library(dplyr)#read relevant package
math <- read.csv("data/student-mat.csv", sep=";")# read math data set
por <- read.csv("data/student-por.csv", sep=";")# read por data set

## 1.2 explore the structure and dimensions
str(math)
str(por)
dim(math); dim(math)

# 2 Join the two data sets using all other variables than "failures", "paid", 
#"absences", "G1", "G2", "G3" as (student) identifiers. Keep only the students 
#present in both data sets. Explore the structure and dimensions of the joined 
#data. 

## 2.1 pass the column names for (and not for) joining into objects
free_cols <- c("failures", 
               "paid", 
               "absences", 
               "G1", 
               "G2", 
               "G3") # column names not for joining
join_cols <- setdiff(colnames(por), 
                     free_cols) # column names for joining

## 2.2 join the data sets
math_por <- inner_join(math, 
                       por, 
                       by = join_cols, 
                       suffix = c(".math", ".por")) 

## 2.3 explore the structure and dimensions
str(math_por)
dim(math_por)


# 3 Get rid of the duplicate records in the joined data set
alc <- select(math_por, all_of(join_cols))
for(col_name in free_cols) {
  # select two columns from 'math_por' with the same original name
  two_cols <- select(math_por, starts_with(col_name))
  # select the first column vector of those two columns
  first_col <- select(two_cols, 1)[[1]]
  
  # then, enter the if-else structure!
  # if that first column vector is numeric...
  if(is.numeric(first_col)) {
    # take a rounded average of each row of the two columns and
    # add the resulting vector to the alc data frame
    alc[col_name] <- round(rowMeans(two_cols))
  } else { # else (if the first column vector was not numeric)...
    # add the first column vector to the alc data frame
    alc[col_name] <- first_col
  }
}

# 4 Generating new variables

## 4.1 create alc_use
alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)

## 4.2 create high_use
alc <- mutate(alc, high_use = alc_use > 2)
colnames(alc)


# 5 Check and save the new data set

# 5.1 Check the dimensions
dim(alc)

# 5.2 Save the data set
write_csv(alc, "data/alc.csv")
