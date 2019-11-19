#IODS Course Excercises set 2
#Otto Mykkänen, University of Eastern Finland
#
# Date strated 4.11.2019 
# Date finished 11.11.2019
#
#"Data wrangling and data analysis"
# 

# read the data into memory (task1)

lrn14 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)

# Looking at the dimensions of the data with dim()
dim(lrn14)

# Looking at the structure of the data with str()
str(lrn14)

# data seems to have 183 observations with 60 variables

# creating a data analysis set with (gender, age, attiutude, deep, stra, surf and points) (task2)
# since struggled las time with this will redo using all steps in Data Camp and tidyr
#
# print the "Attitude" column vector of the lrn14 data
lrn14$Attitude
# divide each number in the column vector
lrn14$Attitude / 10
# create column 'attitude' by scaling the column "Attitude"
lrn14$attitude <- lrn14$Attitude / 10
# The step with (dlyr) library ... Need to access (this was not easy last time and had to look a while for it)
# 
# Access the dplyr library
library(dplyr)
# Seems to still state that some parts are masked, missing.. 
# filter and lag from stats and 4 objects from pkg base >>>
# Well I hope we do not need them allthough filter seems relevant ; )
# >>>> I activated 2 more packages in Studio " stats4" and "base64" already within the listed ones and now seems to get diplyr fine : ) 
# Lucky or resourcefull, either way ok for now. 

# questions related to deep, surface and strategic learning
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")

# select the columns related to deep learning and create column 'deep' by averaging
deep_columns <- select(lrn14, one_of(deep_questions))
lrn14$deep <- rowMeans(deep_columns)
# Got an error message here ||| Error in is.data.frame(x) : object 'deep_columns' not found
# Meanwhile also keyboard changed to english uk, which is not fun if do not see it right away
#
#so I strat by saving the datafile to my computer and go from there
save(data, file = "data.Rdata")
# ok saved also as data_analysis R file. ( used info on sight https://www.r-bloggers.com/how-to-save-and-load-datasets-in-r-an-overview/)
# also reinstalled dlyr since feel the filtering etc might effect data analysis
install.packages("dplyr")
library(dplyr)
# note! In DataCamp the same errors appeared regarding filtering et packages!!
#>> so I tried to get the package in DataCamp but took too long
# >> meaning did not work.

# now no comments or error messages (will still work with the )
lrn14$attitude <- lrn14$Attitude / 10
#reassigned the questions for deep surface and strategic
#
#All steps assinging worked fine in console - did them line by line
#
# deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
# surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
# strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")
# deep_columns <- select(lrn14, one_of(deep_questions))
# lrn14$deep <- rowMeans(deep_columns)
# surface_columns <- select(lrn14, one_of(surface_questions))
# lrn14$surf <- rowMeans(surface_columns)
# strategic_columns <- select(lrn14, one_of(strategic_questions))
# lrn14$stra <- rowMeans(strategic_columns)
#
keep_columns <- c("gender","Age","attitude", "deep", "stra", "surf", "Points")
learning2019OM <- select(lrn14, one_of(keep_columns))
#
# explored with structure 183ob and 7 varables!
# great! seems to be allmost there! 
colnames(learning2019OM)[2] <- "age"
colnames(learning2019OM)[7] <- "points"
# used colnames() sew view and data fine

# now last steps filetring the zero values of points
learning2019OM <- filter(learning2019OM, points > "0")
str(learning2019OM)
#'data.frame':	166 obs. of  7 variables: 
#ok according to the guidelines

# Set up the working directory... 2 ways or more
# used tool from files > More > "this makes a script on console..
#> setwd("~/IODS-project")

# Write CSV in R
write.csv(learning2019OM, file = "learning2019OM.csv")
# since the working directory is open I could observe that the file was crreated right away!! Great!
#
read.csv(learning2019OM)
# first set reading did not work?? 
#Error in read.table(file = file, header = header, sep = sep, quote = quote,  : 
#'file' must be a character string or connection
#
# Since straing coding in console did not work the traditional way was fine
learning2019OM <- read.csv("~/IODS-project/learning2019OM.csv")
str(learning2019OM)
# the only thing is one variable increased due to type of variable included
# but I hope this is fine and actually more correct?
'data.frame':	166 obs. of  8 variables:
#  $ X       : int  1 2 3 4 5 6 7 8 9 10 ...
#$ gender  : Factor w/ 2 levels "F","M": 1 2 1 2 2 1 2 1 2 1 ...
#$ age     : int  53 55 49 53 49 38 50 37 37 42 ...
#$ attitude: num  3.7 3.1 2.5 3.5 3.7 3.8 3.5 2.9 3.8 2.1 ...
#$ deep    : num  3.58 2.92 3.5 3.5 3.67 ...
#$ stra    : num  3.38 2.75 3.62 3.12 3.62 ...
#$ surf    : num  2.58 3.17 2.25 2.25 2.83 ...
#$ points  : int  25 12 24 10 22 21 21 31 24 26 ...
  
head(learning2019OM)
#X gender age attitude     deep  stra     surf points
# 1      F  53      3.7 3.583333 3.375 2.583333     25
# 2      M  55      3.1 2.916667 2.750 3.166667     12
# 3      F  49      2.5 3.500000 3.625 2.250000     24
# 4      M  53      3.5 3.500000 3.125 2.250000     10
# 5      M  49      3.7 3.666667 3.625 2.833333     22
# 6      F  38      3.8 4.750000 3.625 2.416667     21
#

