#
# IODS Excercise 6 
#
# by Otto Mykkänen - University of Eastern Finland/ Savonia Code Academy 
#
# Created 17.11.2019 - 18.11.2019
# 
# 
# 
#  
# Further discriptions and attributes: 
# libraries used in this data analyses
#
library(psych)
library(pastecs)
library(GGally)
library(ggplot2)
library(ggpubr)
library(dplyr)
library(tidyr)
#
#
# Reading the data 
#
BPRS <- read.csv("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", header = T)
#
RATS <- read.csv("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", header = T)
#
# used load data options to get better looking data (whitespace) as separator.
# use view(df) to see first the data (automatic when opening) 

BPRS <- read.csv("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep  = " ", header = T)

RATS <- read.csv("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", sep  = "\t", header = T)
# better loaded with "import dataset and used whitespace as separator
#Looking at PBRS data
head(BPRS)
colnames(BPRS)
str(BPRS)
#
#Looking at RATS data
head(RATS)
colnames(RATS)
str(RATS)

#Saving data 
write.table(RATS, file = "rats_original.txt")
write.table(BPRS, file = "bprs_original.txt")

#The categorial variables found in BPRS (treatment and subject) and (Group and ID)
#in the dataset of RATS transformend to vectors 

#BPRRSL data
BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)

#RATS data
RATS$Group <- factor(RATS$Group)
RATS$ID <- factor(RATS$ID)

#Convertong  to long form and adding a week variable to BPRS 
#and a Time variable to RATS (#3)

#BPRRSLong data
BPRSL <-  BPRS %>% gather(key = weeks, value = bprs, -treatment, -subject)

BPRSL <-  BPRSL %>% mutate(week = as.integer(substr(weeks,5,5)))

#checking up
head(BPRSL)
dim(BPRS)
dim(BPRSL)
ggplot(BPRSL, aes(x = week, y = bprs, linetype = subject)) +
  geom_line() +
  scale_linetype_manual(values = rep(1:10, times=4)) +
  facet_grid(. ~ treatment, labeller = label_both) +
  theme(legend.position = "none") + 
  scale_y_continuous(limits = c(min(BPRSL$bprs), max(BPRSL$bprs)))

#RATSLong data

RATSL <- RATS %>%
  gather(key = WD, value = Weight, -ID, -Group) %>%
  mutate(Time = as.integer(substr(WD,3,4))) 

#checking up
head(RATSL)
dim(RATS)
dim(RATSL)
ggplot(RATSL, aes(x = Time, y = Weight, group = ID)) +
  geom_line(aes(linetype = Group)) +
  scale_x_continuous(name = "Time (days)", breaks = seq(0, 60, 10)) +
  scale_y_continuous(name = "Weight (grams)") +
  theme(legend.position = "top")










#BLOTS

#BPRSL
# Number of weeks, baseline (week 0) included
n <- BPRSL$week %>% unique() %>% length()
# Summary data with mean and standard error of bprs by treatment and week 
BPRSS <- BPRSL %>%
  group_by(treatment, week) %>%
  summarise( mean = mean(bprs), se = sd(bprs)/sqrt(n) ) %>%
  ungroup()
# Glimpse the data
glimpse(BPRSS)

# Plot the mean profiles
ggplot(BPRSS, aes(x = week, y = mean, linetype = treatment, shape = treatment)) +
  geom_line() +
  scale_linetype_manual(values = c(1,2)) +
  geom_point(size=3) +
  scale_shape_manual(values = c(1,2)) +
  geom_errorbar(aes(ymin = mean - se, ymax = mean + se, linetype="1"), width=0.3) +
  theme(legend.position = c(0.8,0.8)) +
  scale_y_continuous(name = "mean(bprs) +/- se(bprs)")











