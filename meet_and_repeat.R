#Omolara Mofikoya
BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep  =" ", header = T)
RATS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", header = TRUE, sep = '\t')
#data BPRS
names(BPRS)
glimpse(BPRS)
str(BPRS)
summary(BPRS)

#data RATS
str(RATS)
names(RATS)
glimpse(RATS)
summary(RATS)

#convert variables to factors
BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)

#convert to long form
BPRSL <-  BPRS %>% gather(key = weeks, value = bprs, -treatment, -subject)
BPRSL <-  BPRSL %>% mutate(week = as.integer(substr(weeks,5,5)))

#look at the data
names(BPRSL)
str(BPRSL)
glimpse(BPRSL)
summary(BPRSL)

# RATS data, convert variable to factor
RATS$ID <- factor(RATS$ID)
RATS$Group <- factor(RATS$Group)

#convert to long form
RATSL <- RATS %>%
  gather(key = WD, value = Weight, -ID, -Group) %>%
  mutate(Time = as.integer(substr(WD,3,4))) 
#look at the data
names(RATSL)
str(RATSL)
glimpse(RATSL)
summary(RATSL)
