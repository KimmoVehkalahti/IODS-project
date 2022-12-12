#Name: Subam Kathet

#Date: 11/12/2022

#**Introduction to open data science**#

#Week 6: Analysis of longitudinal data

#This weeks learning tasks includes exercises from week 6 - Analysis of longitudinal Data

#All exercises of this week are based on the Chapters 8 and 9 of Vehkalahti and Everitt (2019)

#included in the special edition MABS4IODS (Part VI)

#For more information https://github.com/KimmoVehkalahti/MABS

#Data wrangling exercise will be completed by preparing two data sets for Analysis exercise

#Important skill to work on is "Converting the data between the wide form and the long form"

#**LETS START THE WRANGLING PROCESS**#

#loading the packages first !! 

library(dplyr)
library(tidyr)

###**STEP 1**### Loading the data set

# Read the BPRS data
BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep =" ", header = T)

# Look at the (column) names of BPRS
colnames(BPRS)

# Look at the structure of BPRS
str(BPRS)

# Print out summaries of the variables
summary(BPRS); dim(BPRS)

#BPRS data set has 40 observations and 11 variable

# Read the RATS data
RATS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", sep ="\t", header = T)

# Look at the (column) names of RATS
colnames(RATS)

# Look at the structure of RATS
str(RATS)

# Print out summaries of the variables
summary(RATS); dim(RATS)

#RATS data set has 16 observations and a single variable (this might change after wrangling, lets seee !!)

###**STEP 2**### Converting the categorical variables to factors

#BPRS data
BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)

#RATS data
RATS$ID <- factor(RATS$ID) 
RATS$Group <- factor(RATS$Group)

###**STEP 3**### Converting the data sets to long form

# Convert to long form and extract the week number (lets write the codes together)

BPRSL <-  pivot_longer(BPRS, cols = -c(treatment, subject),
                       names_to = "weeks", values_to = "bprs") %>%
  arrange(weeks) #order by weeks variable

# Extract the week number
BPRSL <-  BPRSL %>% 
  mutate(week = as.integer(substr(weeks, 5, 5)))

# Take a glimpse at the BPRSL data
glimpse(BPRSL)

#And same with RATS data

RATSL <- pivot_longer(RATS, cols = -c(ID, Group), 
                      names_to = "WD",
                      values_to = "Weight") %>% 
  mutate(Time = as.integer(substr(WD, 3, 4))) %>% # Extract the week number
  arrange(Time) #order by Time variable

# Take a glimpse at the RATSL data
glimpse(RATSL)


###**STEP 4**### Checking the variables
str(BPRS); str(BPRSL)
str(RATS); str(RATSL)


###**STEP 4**### Save the data as .csv

write.csv(BPRSL, "BPRSL.csv")
write_csv(RATSL, "RATSL.csv")

#Lets check 
read_csv("BPRSL.csv")
read_csv("RATSL.csv")

###All done !!!! 

###DATA WRANGLING COMPLETE !!!! 







