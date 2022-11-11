#Rong Guang
#8/11/2022
#Data wrangling task in assignment 2.


#1 import data to object "learn"  
learn <- 
  read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", 
             sep="\t", 
             header=TRUE)

##1.1 check the dimensions of learn
dim(learn)
##finding: data frame "learn" contains 183 observations of 60 variables.

##1.2 check the structure of learn
str(learn)
##finding: "learn" is a data frame. It has 59 numeric variables (integer 
##sub-type), among which 56 are with values ranging from one to five. There is 
##one character variable, which has dichotomous values of F and M. 


#2 Create an analysis dataset with the variables gender, age, attitude, deep, 
#stra, surf and points

##2.1 create column 'attitude' by scaling the column "Attitude"
learn$attitude <- learn$Attitude / 10 #Global attitude toward statistics 
                                      #~Da+Db+Dc+Dd+De+Df+Dg+Dh+Di+Dj 

##2.2 create column 'deep' by taking the mean of deep-related items.
deep_questions <- c("D03",  #item: I usually try to understand the meaning of 
                    #what I am learning.
                    "D11",  #item: When I read a book or article, I try to get
                    #a good idea of what the author is trying to say.
                    "D19",  #item: When I read, I stop from time to time to 
                    #think about what I am trying to learn from the text.
                    "D27",  #item: Before I start solving a task or problem, 
                    #I try to find out what it is based on.
                    "D07",  #item: I try to compare ideas and concepts from 
                    #different courses whenever possible.
                    "D14",  #item:  When working on a new and unfamiliar 
                    #topic, I compare it with what I have learned before.
                    "D22",  #item:  I often find myself reflecting on the ideas 
                    #raised by scientific texts and the interconnections between 
                    #them.
                    "D30", #item: I like to think about things related to my 
                    #studies, even if it doesn't lead to anything.
                    "D06",  #item: I look carefully for reasons and evidence to 
                    #form my own conclusions about what I am studying.
                    "D15", #item: I often find myself questioning things I have  
                    #read in lectures and books.
                    "D23", #item: When I read, I look carefully at how the 
                    #details fit into the whole.
                    "D31") #item: It is important for me to find reasons for 
                    #arguments and to see the reason behind things.
learn$deep <- rowMeans(lrn14[, deep_questions])

##2.3 create column 'surf' by taking the mean of surface_questions-related items.
surface_questions <- c("SU02",#I often wonder whether my studies are actually 
                       #useful.
                       "SU10",#item: Not much of what I have studied has been 
                       #very interesting or relevant.
                       "SU18",#item: I sometimes wonder why I decided to study 
                       #here in the first place.
                       "SU26",#item: My studies include courses that I am not 
                       #interested in, but I have to take them anyway.
                       "SU05",#item: There are many things that I have to 
                       #concentrate on just memorizing. 
                       "SU13",#item: Many of the things I learn often remain 
                       #disconnected and do not link to the bigger picture.
                       "SU21",#item: I often don't really know what is important 
                       #in the lectures, so I try to take notes as much as possible.
                       "SU29",#item: I often have difficulty understanding 
                       #things I need to remember.
                       "SU08",#item: I usually study for the exam as much as I 
                       #think is enough to pass the exam.
                       "SU16",#item: Not much of what I have studied has been 
                       #very interesting or relevant.
                       "SU24",#item: In my studies, I concentrate mainly on what 
                       #seems to be related to the completion of assignments and 
                       #exams.
                       "SU32" #item: I like the fact that the course tells me 
                       #exactly what to do in essays or coursework.
                       ) 
learn$surf <- rowMeans(lrn14[, surface_questions])

##2.4 create column 'stra'.
strategic_questions <- c("ST01",#item: I organize my study conditions in such a 
                         #way that it is easy for me to work.
                         "ST09",#item: I think I am quite systematic when 
                         #revising for the exam.
                         "ST17",#item: I am good at following lecturers' 
                         #instructions on reading.
                         "ST25",#item: I usually plan my weekly programme 
                         #either on paper or in my head.
                         "ST04",#item: I organize my study time so that I can 
                         #make the most of it.
                         "ST12",#item: I am good at grabbing a study whenever 
                         #I need to.
                         "ST20",#item: I work steadily throughout the period, 
                         #rather than leaving everything to the last minute.
                         "ST28" #item: I usually make efficient use of the whole 
                         #day.
                         )
learn$stra <- rowMeans(lrn14[, strategic_questions])

##2.5 combine new variables into data set for analysis
learn <- learn[, c("gender",#item: Male = 1  Female = 2
                   "Age",#Age (in years) derived from the date of birth
                   "attitude", 
                   "deep", 
                   "stra", 
                   "surf", 
                   "Points")]

##2.6 Exclude observations where the exam points variable is zero
learn <- filter(learn, Points != 0)

##2.7 Check if the number of observations reduced to 166
dim(learn)

##2.8 Fine-tune variable names to get better consistency
###2.8.1 rename "Age" to "age"
colnames(learn)[which(colnames(learn) == "Age")] <- "age"
###2.8.2 rename "Points" to "point"
colnames(learn)[which(colnames(learn) == "Points")] <- "points"

#3 Save analysis data set

library(tidyverse)

##3.1 set working directory
setwd("/Users/rongguang/Documents/IODS-project")

##3.2 save to data folder
write_csv(learn, file ="data/learning2014.csv")

##3.3 read the data set
learn.read <- read_csv("data/learning2014.csv")

##3.4 check the data set 
###3.4.1 check structure
str(learn.read)
###3.4.2 check the first 20 observations
head(learn.read, 20)
















