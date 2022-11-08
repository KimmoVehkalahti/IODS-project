#Rong Guang
#8/11/2022
#Data wrangling task in assignment 2.

learn <- 
  read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", 
             sep="\t", 
             header=TRUE)



learn <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)
learn$attitude <- learn$Attitude / 10
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
learn$deep <- rowMeans(lrn14[, deep_questions])
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
learn$surf <- rowMeans(lrn14[, surface_questions])
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")
learn$stra <- rowMeans(lrn14[, strategic_questions])
learn <- learn[, c("gender","Age","attitude", "deep", "stra", "surf", "Points")]
colnames(learning2014)[which(colnames(learn) == "Age")] <- "age"
colnames(learning2014)[which(colnames(learn) == "Points")] <- "points"
learn
