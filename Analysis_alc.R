#
# IODS Excercise 3 
#
# by Otto Mykkänen - University of Eastern Finland/ Savonia Code Academy 
#
# Created 13.11.2019 -
# 
# Dataset is from a study analysing secondary education level achievements in Portugese Schools.
# The two distinc datasets are representing mathematical (mat) or Portugese languange (por) perfomances.
#  
# Further discriptions and attributes: https://archive.ics.uci.edu/ml/datasets/Student+Performance
#
# libraries used in this data analyses

library(psych)
library(pastecs)
library(GGally)
library(ggplot2)
library(ggpubr)
library(dplyr)
library(tidyr)


# Reading the data ( with linked)

joined_alc<- read.table("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/alc.txt", sep=",", header=TRUE)  

# explorations

dim(joined_alc)
glimpse(joined_alc)
joined_alc %>% group_by(sex) %>% summarise(count = n(), mean_grade = mean(G3))
stat.desc(joined_alc)
gather(joined_alc) %>% glimpse
gather(joined_alc) %>% ggplot(aes(value)) + facet_wrap("key", scales = "free") + geom_bar()

#Choosing 4 variables in the data those are interesting in relation to alcohol high/low consumption. Including hypothesis (3#).
#select only the 4 variable columns and some extra to keep dataset smaller and easier for visualizations
keep_columns <- c("gender","high_use", "absences","famrel", "health", "freetime", "studytime", "G3", "alc_use")
smjoined_alc <- select(joined_alc, one_of(keep_columns))

library(ggpubr)
p1 <- ggplot(joined_alc, aes(health)) + geom_histogram(color="white", fill="darkgreen", binwidth = 1)
p2 <- ggplot(joined_alc, aes(famrel)) + geom_histogram(color="white", fill="darkgreen", binwidth = 1)
p3 <- ggplot(joined_alc, aes(studytime)) + geom_histogram(color="white", fill="darkgreen", binwidth = 1)
p4 <- ggplot(joined_alc, aes(absences)) + geom_histogram(color="white", fill="darkgreen", binwidth = 1)


figure <- ggarrange(p1, p2, p3, p4, 
                    labels = c("health", "familyrelations", "studytime", "absences"),
                    ncol = 2, nrow = 2)
figure

smjoined_alc %>% group_by(high_use) %>% summarise(count = n(), Health = mean(health))
smjoined_alc %>% group_by(high_use) %>% summarise(count = n(), Family_relations = mean(famrel))
smjoined_alc %>% group_by(high_use) %>% summarise(count = n(), Studytime_used = mean(studytime))
joined_alc %>% group_by(high_use) %>% summarise(count = n(), smAbsences_time = mean(absences))

# all rest code available in sections of diary 

# 8 Task

#model 9
modeln9 <- glm(high_use ~ age + health + Fedu + traveltime + studytime + failures + famrel + freetime + absences, data = joined_alc, family = "binomial")
probabilities <- predict(modeln9, type = "response")
joined_alc <- mutate(alc, probability = probabilities)
loss_func <- function(class, prob) {
  n_wrong <- abs(class - prob) > 0.5
  mte9 <- mean(n_wrong)
  mte9
}
loss_func(class = joined_alc$high_use, prob = joined_alc$probability)
cv <- cv.glm(data = joined_alc, cost = loss_func, glmfit = modeln9, K = 10)
mtr9 <- cv$delta[1]
mtr9



#model 8
modeln8 <- glm(high_use ~ age + health + traveltime + studytime + failures + famrel + freetime + absences, data = joined_alc, family = "binomial")
probabilities <- predict(modeln8, type = "response")
joined_alc <- mutate(alc, probability = probabilities)
loss_func <- function(class, prob) {
  n_wrong <- abs(class - prob) > 0.5
  mte8 <- mean(n_wrong)
  mte8
}
loss_func(class = joined_alc$high_use, prob = joined_alc$probability)
cv <- cv.glm(data = joined_alc, cost = loss_func, glmfit = modeln8, K = 10)
mtr8 <- cv$delta[1]
mtr8





#model 7
modeln7 <- glm(high_use ~ age + traveltime + studytime + failures + famrel + freetime + absences, data = joined_alc, family = "binomial")
probabilities <- predict(modeln7, type = "response")
joined_alc <- mutate(alc, probability = probabilities)
loss_func <- function(class, prob) {
  n_wrong <- abs(class - prob) > 0.5
  mte7 <- mean(n_wrong)
  mte7
}
loss_func(class = joined_alc$high_use, prob = joined_alc$probability)
cv <- cv.glm(data = joined_alc, cost = loss_func, glmfit = modeln7, K = 10)
mtr7 <- cv$delta[1]
mtr7




#model 6
modeln6 <- glm(high_use ~ traveltime + studytime + failures + famrel + freetime + absences, data = joined_alc, family = "binomial")
probabilities <- predict(modeln6, type = "response")
joined_alc <- mutate(alc, probability = probabilities)
loss_func <- function(class, prob) {
  n_wrong <- abs(class - prob) > 0.5
  mte6 <- mean(n_wrong)
  mte6
}
loss_func(class = joined_alc$high_use, prob = joined_alc$probability)
cv <- cv.glm(data = joined_alc, cost = loss_func, glmfit = modeln6, K = 10)
mtr6 <- cv$delta[1]
mtr6




#model 5
modeln5 <- glm(high_use ~ traveltime + studytime + famrel + freetime + absences, data = joined_alc, family = "binomial")
probabilities <- predict(modeln5, type = "response")
joined_alc <- mutate(alc, probability = probabilities)
loss_func <- function(class, prob) {
  n_wrong <- abs(class - prob) > 0.5
  mte5 <- mean(n_wrong)
  mte5
}
loss_func(class = joined_alc$high_use, prob = joined_alc$probability)
cv <- cv.glm(data = joined_alc, cost = loss_func, glmfit = modeln5, K = 10)
mtr5 <- cv$delta[1]
mtr5




#model 4
modeln4 <- glm(high_use ~ studytime + famrel + freetime + absences, data = joined_alc, family = "binomial")
probabilities <- predict(modeln4, type = "response")
joined_alc <- mutate(alc, probability = probabilities)
loss_func <- function(class, prob) {
  n_wrong <- abs(class - prob) > 0.5
  mte4 <- mean(n_wrong)
  mte4
}
loss_func(class = joined_alc$high_use, prob = joined_alc$probability)
cv <- cv.glm(data = joined_alc, cost = loss_func, glmfit = modeln4, K = 10)
mtr4 <- cv$delta[1]
mtr4



#model 3
modeln3 <- glm(high_use ~ studytime + freetime + absences, data = joined_alc, family = "binomial")
probabilities <- predict(modeln3, type = "response")
joined_alc <- mutate(alc, probability = probabilities)
loss_func <- function(class, prob) {
  n_wrong <- abs(class - prob) > 0.5
  mte3 <- mean(n_wrong)
  mte3
}
loss_func(class = joined_alc$high_use, prob = joined_alc$probability)
cv <- cv.glm(data = joined_alc, cost = loss_func, glmfit = modeln3, K = 10)
mtr3 <- cv$delta[1]
mtr3






#model 2
modeln2 <- glm(high_use ~ freetime + absences, data = joined_alc, family = "binomial")
probabilities <- predict(modeln2, type = "response")
joined_alc <- mutate(alc, probability = probabilities)
loss_func <- function(class, prob) {
  n_wrong <- abs(class - prob) > 0.5
  mte2 <- mean(n_wrong)
  mte2
}
loss_func(class = joined_alc$high_use, prob = joined_alc$probability)
cv <- cv.glm(data = joined_alc, cost = loss_func, glmfit = modeln2, K = 10)
mtr2 <- cv$delta[1]
mtr2





#model 1
modeln1 <- glm(high_use ~ absences, data = joined_alc, family = "binomial")
probabilities <- predict(modeln1, type = "response")
joined_alc <- mutate(alc, probability = probabilities)
loss_func <- function(class, prob) {
  n_wrong <- abs(class - prob) > 0.5
  mte1 <- mean(n_wrong)
  mte1
}
loss_func(class = joined_alc$high_use, prob = joined_alc$probability)
cv <- cv.glm(data = joined_alc, cost = loss_func, glmfit = modeln1, K = 10)
mtr1 <- cv$delta[1]
mtr1


