#Name: Subam Kathet
#Date: 19 November 2022

#IODS Exercise set 3 - Logistic Regression
#R-learning codes for Logistic Regression 

#We will be working with two new data sets retrieved from the [UCI Machine Learning Repository]
#Resource for data base: https://archive.ics.uci.edu/ml/datasets.html
#The data are from two identical questionnaires related to secondary school student alcohol consumption in Portugal

#This script consists all the codes used during the data wrangling exercise

# LET'S START !!! 

#Two csv files has been downloaded in the course folder from the resource mention above. 

#Import data set into R 

math <- read.table("student-mat.csv", sep = ";", header = TRUE)
por <- read.table("student-por.csv", sep = ";", header = TRUE)


# Let's see how the data looks 

##data set math
dim(math)
str(math)
colnames(math)


##data set por
dim(por)
str(por)
colnames(por)

# Lets join the two columns

#But before that we set the columns not to use as identifier
free_cols <- c("failures", "paid", "absences", "G1", "G2", "G3")

# Then set columns to be joined
join_cols <- setdiff(colnames(por), free_cols)

# And finally join columns
math_por <- inner_join(math, por, by = join_cols, suffix = c(".math", ".por"))

#Let's see how the data set looks now ! 
str(math_por)
dim(math_por)

#370 rows and 39 columns

#Removing the duplicated
#now getting rid of duplicates

alc <- select(math_por, all_of(join_cols))


for(col_name in free_cols) {
  
  two_cols <- select(math_por, starts_with(col_name))
  
  first_col <- select(two_cols, 1)[[1]]
  
  
  if(is.numeric(first_col)) {
    
    alc[col_name] <- round(rowMeans(two_cols))
  } else { 
    alc[col_name] <- first_col
  }
}

# glimpse at the new combined data
glimpse(alc)
dim(alc)
#Now data has 370 rows and 33 columns

#Joining two data sets and making changes
## calculating weekday and weekend average alcohol consumption and add column
alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)

## adding a new column "high use" if consumption value is greater than 2
alc <- mutate(alc, high_use = alc_use > 2)


# Lets make .csv file and export this into the project folder
write_csv(alc, "alc.csv")
glimpse(alc)

# Lets look at the final outcome
glimpse(math_por)
glimpse(alc)

#Rows: 370
#Columns: 35

#Everything looks fine !!!





























