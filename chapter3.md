Untitled
================

\#this data shows student achievement in secondary education of two
Portuguese schools in mat and por ,

str(alc) \# lets study the relationship between high and low users of
alcohol by using some variables \# access the tidyverse libraries dplyr
and ggplot2 library(dplyr); library(ggplot2); library(tidyr)

# produce summary statistics by group

alc %\>% group\_by(sex, high\_use) %\>% summarise(count = n(),
mean\_grade = mean(G3)) \#alc %\>% group\_by(sex, absences,
health,activities, high\_use) %\>% summarise(count = n(), mean\_grade =
mean(G3)) \#From the gender, we can see that ther are less high alcohol
consumers in both male and female , and for the females the high alcohol
consumers tend to have an higer grade while it is the opposite for males
alc \<- alc %\>% group\_by(absences, high\_use) %\>% summarise(count =
n(), mean\_grade = mean(G3)) alc gather(alc) %\>% glimpse
