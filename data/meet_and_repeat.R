#Load the data sets (BPRS and RATS) into R using as the source the GitHub 
#repository of MABS, where they are given in the wide form:

bprs <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", 
                   sep =" ", 
                   header = T)

rats <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", 
                   header = TRUE, 
                   sep = '\t')
write.csv(bprs, "data/bprs.csv")
write.csv(rats, "data/rats.csv")

#check their variable names, 
names(bprs);names(rats)


#view the data contents and structures
library(tidyverse)
view(bprs)
view(rats)

#and create some brief summaries of the variables
summary(bprs);summary(rats)

bprs$treatment <- factor(bprs$treatment)  #convert to factor
bprs$subject <- factor(bprs$subject)

class(bprs$treatment);class(bprs$subject) #check the variable type

rats <- rats %>% mutate(ID = factor(ID), #another way to convert to factor
                        Group = factor(Group))

sapply(rats, function(x)class(x))#check the variable type


#Convert the data sets to long form. 
#Add a week variable to BPRS and a Time variable to RATS. 
bprsl <- bprs %>% 
  pivot_longer(cols =-c("treatment","subject"),
               names_to = "week",
               values_to = "rating") %>% 
  mutate(week = as.integer(substr(week, 5,5))) %>% 
  arrange(week)

ratsl <- rats %>% 
  pivot_longer(cols =-c(1:2),
               names_to = "time",
               values_to = "weight") %>% 
  mutate(time = as.integer(substr(time, 3,4))) %>% 
  arrange(time)



