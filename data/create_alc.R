# Liyuan E, 10.11.2020, the third homework for introduction to open data science, data source:https://archive.ics.uci.edu/ml/datasets/Student+Performance

# Read the data 
url <- "http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets"
url_mat <- paste(url, "student-mat.csv", sep = "/")
mat <- read.table(url_mat, sep = ";", header=TRUE)
#col.names=c("school","sex","age","address","famsize","Pstatus","Medu","Fedu","Mjob","Fjob","reason","nursery","internet")
url_por <- paste(url, "student-por.csv", sep = "/")
por <- read.table(url_por, sep = ";", header = TRUE)

# explore the structure and dimension of the data

str(mat)
dim(mat)

str(por)
dim(por)

#Join two data sets using the variables identifiers

library(dplyr)
join_by <- c("school","sex","age","address","famsize","Pstatus","Medu","Fedu","Mjob","Fjob","reason","nursery","internet")
mat_por <- inner_join(mat, por, by = join_by, suffix = c(".mat", ".por"))
colnames(mat_por)
str(mat_por)
dim(mat_por)
merged <- merge(mat, por)#try to merge two data sets
duplicated(mat_por)#try to find duplicated variables, I do not find the extra 12 individual in the data.

# The if-else structure

colnames(mat_por)
alc <- select(mat_por, one_of(join_by))
notjoined_columns <- colnames(mat)[!colnames(mat) %in% join_by]
notjoined_columns
for(column_name in notjoined_columns) {
  two_columns <- select(mat_por, starts_with(column_name))
  first_column <- select(two_columns, 1)[[1]]
  if(is.numeric(first_column)) {
    alc[column_name] <- round(rowMeans(two_columns))
  } else { 
    alc[column_name] <- first_column
  }
}
glimpse(alc)

# Take the average answer to weekday and weekend alcohol consumption to create a new column

alc <- mutate (alc, alc_use = (Dalc + Walc)/2)
alc <- mutate (alc, high_use = alc_use > 2)
alc

# Glimpse at the joined and modified data and save

glimpse(alc)
write.csv(alc,file="data/third_homework.csv")




