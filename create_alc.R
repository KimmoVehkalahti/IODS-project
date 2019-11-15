#
# IODS Excercise 3 
#
# by Otto Mykkänen - University of Eastern Finland/ Savonia Code Academy 
#
# Created 13.11.2019 -
# 
# Dataset is from a study analysing secondary education level achievements in Portugese Schools.
# The two distinc datasets are representing mathematical (mat) or Portugese languange (por) perfomances.
#  
# Further discriptions and attributes: https://archive.ics.uci.edu/ml/datasets/Student+Performance
#
# 

# Reading the data
math <- read.csv("~/IODS-project/data/student-mat.csv", sep=";")
por <- read.csv("~/IODS-project/data/student-por.csv", sep=";")




# Using library with inner_join function to join two datasets and exploring it

library(dplyr)

join_by <- c("school","sex","age","address","famsize","Pstatus","Medu","Fedu","Mjob","Fjob","reason","nursery","internet")
math_por <- inner_join(math, por, by = join_by, suffix = c(".math", ".por"))
colnames(math_por)

# Counting average of dublicate answers with a if else structure command

# create a new data frame with only the joined columns
alc <- select(math_por, one_of(join_by))

# columns that were not used for joining the data
notjoined_columns <- colnames(math)[!colnames(math) %in% join_by]

# print out the columns not used for joining
notjoined_columns

# for every column name not used for joining...
for(column_name in notjoined_columns) {
  # select two columns from 'math_por' with the same original name
  two_columns <- select(math_por, starts_with(column_name))
  # select the first column vector of those two columns
  first_column <- select(two_columns, 1)[[1]]
  
  # if that first column  vector is numeric...
  if(is.numeric(first_column)) {
    # take a rounded average of each row of the two columns and
    # add the resulting vector to the alc data frame
    alc[column_name] <- round(rowMeans(two_columns))
  } else { # else if it's not numeric...
    # add the first column vector to the alc data frame
    alc[column_name] <- first_column
  }
}
#Creating a high use column for high alcholo users >2 (#6)
#And plotted the data

alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)
alc <- mutate(alc, high_use = alc_use > 2)
g2 <- ggplot(data = alc)
g2 + geom_bar(data = alc, aes(x = alc_use))+ facet_wrap("sex")
dim(alc)
glimpse(alc)

#Saving joined and modified data 

write.csv(math_por, file = "math_por.csv")
write.csv(alc, file = "alc.csv")
