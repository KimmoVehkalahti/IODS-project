#1. Load the data sets (BPRS and RATS) into R using as the source the GitHub 
#repository of MABS, where they are given in the wide form:

bprs <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", 
                   sep =" ", 
                   header = T)

rats <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", 
                   sep =" ", 
                   header = T)
write.csv(bprs, "/data/bprs.csv")
