
#Omolara Mofikoya
#18/11/2019
#logistic Regression   https://archive.ics.uci.edu/ml/datasets/Student+Performance

#Read the mat and por data
mat <- read.csv("~/IODS-project/data/student-mat.csv",sep = ";" , header=TRUE)
por <- read.csv("~/IODS-project/data/student-por.csv",sep = ";" , header=TRUE)

#determine the structure and dimension of the file
str(mat)
dim(mat)
str(por)
dim(por)

#access the dplyr library
library(dplyr)

#common columns to use as identifiers
join_by <- c("school","sex","age","address","famsize","Pstatus","Medu","Fedu","Mjob","Fjob","reason","nursery","internet")

#join the two datasets by the selected identifiers
mat_por <- inner_join(mat, por, by = join_by, suffix = c(".math", ".por"))

#strructure and dimension of joined file
str(mat_por)
dim(mat_por)

# print out the column names of 'math_por'
mat_por

# create a new data frame with only the joined columns
alc <- select(mat_por, one_of(join_by))
alc

# the columns in the datasets which were not used for joining the data
notjoined_columns <- colnames(mat)[!colnames(mat) %in% join_by]

# print out the columns not used for joining
notjoined_columns

# for every column name not used for joining...
for(column_name in notjoined_columns) {
  # select two columns from 'mat_por' with the same original name
  two_columns <- select(mat_por, starts_with(column_name))
  # select the first column vector of those two columns
  first_column <- select(two_columns, 1)[[1]]

  
  # if that first column vector is numeric...
  if(is.numeric(first_column)) {
    # take a rounded average of each row of the two columns and
    # add the resulting vector to the alc data frame
    alc[column_name] <- round(rowMeans(two_columns))
  } else { # else if it's not numeric...
    # add the first column vector to the alc data frame
    alc[column_name] <- (first_column)
  }
}

# glimpse at the new combined data
glimpse(alc)

# define a new column alc_use by taking the average of weekday and weekend alcohol use
alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)
alc
# define a new logical column 'high_use'for considering student with alcohol use greater than 2
alc <- mutate(alc, high_use = alc_use > 2)
alc
glimpse(alc)

