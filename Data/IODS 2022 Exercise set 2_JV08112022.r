####################################
### Jussi Pekka Vehviläinen 08112022
### IODS 2022 Exercise set 2
####################################


# LIBRARIES

# Own functions

#########################################
### MAIN CODE
#########################################

### Data wrangling
# PART 1
# SET UP WORKING DIR AND BUILD UP DATA FOLDER
setwd("D://IODS-project")
dir.create(paste0(getwd(),"/Data"))
setwd(paste0(getwd(),"/Data"))

# PART 2
# Bring .txt file to R environment which has been downloaded to Data folder
learning_2014<-as.data.frame(read.table("learning2014.txt", header = TRUE, sep = "\t"))

''' Table should have 183 rows and 60 cols containing integer values in all except last column
which contains information about gender by character '''

# PART 2
''' Subset Data set to contain columns: gender, age, attitude, deep, stra, surf and points
Deep is calculated by taking the mean of cols: c("D03","D11","D19","D27","D03","D11","D19","D27","D06","D15","D23","D31") and excluding 0
Stra is calculated by taking the mean of cols: c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28") and excluding 0
Surf is calculated by taking the mean of cols: c("SU02","SU10","SU18","SU26","SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32") and excluding 0'''

# Analysis dataset
analy_dataset<-subset(learning_2014, as.numeric(Points)!=0)
analy_dataset[analy_dataset==0]<-NA

# New DataFrame
df<-data.frame(Gender=analy_dataset$gender,Age=analy_dataset$Age,Attitude=NA, Deep=NA,Stra=NA, Surf=NA, Points=analy_dataset$Points)

# Add Deep by taking the mean
deep <- c("D03","D11","D19","D27","D03","D11","D19","D27","D06","D15","D23","D31")
df$Deep<-rowMeans(analy_dataset[,colnames(analy_dataset) %in% deep], na.rm=TRUE)

# Add Stra by taking the mean
stra <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")
df$Stra<-rowMeans(analy_dataset[,colnames(analy_dataset) %in% stra], na.rm=TRUE)

# Add Surf by taking the mean
surf <- c("SU02","SU10","SU18","SU26","SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
df$Surf<-rowMeans(analy_dataset[,colnames(analy_dataset) %in% surf], na.rm=TRUE)

# Add Attitude by taking the mean
attitude <- c("Da","Db","Dc","Dd","De","Df","Dg","Dh","Di","Dj")
df$Attitude<-rowMeans(analy_dataset[,colnames(analy_dataset) %in% attitude], na.rm=TRUE)

# PART 4
# Change working dir
setwd("D://IODS-project")
# Write results to .csv format file
write.csv2(df,"Data/learning2014.csv")
# Read saved .csv file. Header= TRUE means that file has headers. sep=";" means that values are seperated by ;. dec="," means that in the file , has been used for decimals
learning_2014.2<-as.data.frame(read.table("Data/learning2014.csv", header = TRUE, sep = ";", dec=","))

#########################################
### Analysis
#########################################

# PART 1
# Read file to R environment
''' Data set contains summary results of course 'Johdatus yhteiskuntatilastotieteeseen, syksy 2014' survey.
There should be 7 variables (gender, age, attitude, deep, stra, surf and points) and 166 observations.
Gender: Male = 1  Female = 2
Age: Age (in years) derived from the date of birth
Attitude: Global attitude toward statistics. Mean of original variables (~Da+Db+Dc+Dd+De+Df+Dg+Dh+Di+Dj)
Deep: Deep approach. Mean of original variables (~d_sm+d_ri+d_ue)
Stra: Strategic approach. Mean of original variables ( ~st_os+st_tm)
Surf: Surface approach. Mean of original variables (~su_lp+su_um+su_sb)
Points: Total counts from survey.
More information about used variables can be found from http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS2-meta.txt'''

learning_2014.2<-as.data.frame(read.table("Data/learning2014.csv", header = TRUE, sep = ";", dec=","))
# Dimensions of DataFrame
dim(learning_2014.2)

# PART 2
# Summary
print(summary(learning_2014.2[,2:ncol(learning_2014.2)]))

pairs(learning_2014.2[-(1:2)])

# Scatterplot
p <- ggpairs(learning_2014.2[-(1:2)], mapping = aes(), lower = list(combo = wrap("facethist", bins = 20)))
print(p)

''' Scatterplot matrix is used to describe relationships between the variables. It's constructed from the dataframe with ggpairs -function (ggplot2 -package).
Result plot shows in additon of variables relationships variables diverging and gives correlation coefficients with asterix showing level of significance.
Most promising relationship seems to be between: Attitude and Points, and Surf and Deep.
There seems to be also somekind of relationship between: Stra and Surf.
As overall, matrix gives good overlook of data, and starting point to study more relationships between variables'''


# PART 3 and Part4
# Create a regression model with multiple explanatory variables
my_model2 <- lm(Points ~ Attitude + Stra + Surf, data = learning_2014.2)
summary(my_model2)
'''Summary of a regression model shows that only Attitude seems to correlate significantly with Points.
From the print, you can see model residiuals; summary table (estimate value, std. error, t-value and p-value for all variables in model against Points).
Significance of variable correlation can be read from p-value(last column of Coefficients table). Significance levels threshols are given under the table.
Summary gives also p-value for whole model which isn't significant because model contains variables that hasn't have relationship to Points.
In next step, lest remove other variables from the model and see what happens.'''

# Only Attitude seems to be significant, so lets do model again with only adding it
my_model3 <- lm(Points ~ Attitude, data = learning_2014.2)
summary(my_model3)
'''Now results seems to be better and p-value is significant for the variable relationship as well as for the model.
Multiple R-squared is the proportion of the variation in dependent variable that can be explained by the independent variable. So in the model where we haved three variables
20,74 % of the variation in Points can be explained by variables. But now intresting is that Attitude by itself explains 19,06 % of the variation. Showing us that Stra and Surf effect to the points is pretty minimal.'''

# PART 5
# Study more our model with diagnostic plots
plot(my_model3, which=c(1,2,5))

# From the Residual vs leveragre plot we can check which and how many of observation are influential. In our case data seems good and there isn't any point outside Cook distance lines.
# Also residual vs Fitted plot seems good. Data is divided evenly in x - and y-axel.
# QQ-plot also indicates goodness of our model. If the points runs out too early from the line, there migth be some other variables effecting our relationship more than the Attitude variable.
# In this case QQplot seems to be really nice, but no perfect.
