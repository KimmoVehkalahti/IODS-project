# 1. Load BPRS and RATS data sets, see names, structure and summary of the two data sets

BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep  =" ", header = T)
names(BPRS) # column names of the data
str(BPRS) # structure of the data
summary(BPRS) # summary of the data

RATS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", header = TRUE, sep = '\t')
names(RATS) # colname of the data
str(RATS) # structure of the data
summary(RATS) # summary of the data

# 2. convert the categorical variables to factors

library(dplyr)
library(tidyr)
BPRS$treatment <- factor(BPRS$treatment) #convert BPRS treatment
BPRS$subject <- factor(BPRS$subject) # convert BPRS subject
RATS$ID <- factor(RATS$ID) # convert RATS ID
RATS$Group <- factor(RATS$Group) #convert RATS Group

# 3.Convert to long form ans add variables to BPRS and RATS

BPRSL <-  BPRS %>% gather(key = weeks, value = bprs, -treatment, -subject) # convert BPRS to long form
BPRSL <-  BPRSL %>% mutate(week = as.integer(substr(weeks,5,5))) # add week to BRPS

RATSL <-  RATS %>% gather(key = WD, value = Weight, -ID, -Group)  # convert RATS to long form
RATSL <-  RATSL %>% mutate(Time = as.integer(substr(WD,3,4))) # add Time to RATS

# 4. look at the new data and compare them with their wide form versions 

glimpse(BPRSL) # see BPRSL
glimpse(RATSL) # see RATSL

Comments: The dataset showed that the variable names changed. Take BPRS as an example. The varibales from 
"treatment, subject, week0, week1, week2, week3, week4, week5, week6, week7, and week8" to "treatment, subject, weeks, bprs, and week". 
And to look at the structure of BPRS, it showed that "week0 to week8" in the wide form changed to weeks and bprs. 
So the long form of dataset seperates the unit of analysis(week-bprs) into two separate variables (weeks and bprs),
but the wide form of dataset combines one of the keys (week) with the value variable (bprs). 
In summary, the long form of dataset would easy to summary and can be analyzed in a more advanced way.
