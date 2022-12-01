#Rong Guang
#13/11/2022

library(tidyverse)
hd <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/human_development.csv")
gii <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/gender_inequality.csv", na = "..")

#check structure and dimensions
str(hd)
dim(hd)
str(gii)
dim(gii)

#summarizing variables
summary(hd)
summary(gii)
glimpse(hd)
glimpse(gii)

#rename with shorter names
hd <- hd %>% rename(hdir = `HDI Rank`,
                    hdi = `Human Development Index (HDI)`,
                    lifeexp = `Life Expectancy at Birth`,
                    eduexp = `Expected Years of Education`,
                    edumean = `Mean Years of Education`,
                    gni = `Gross National Income (GNI) per Capita`,
                    g_h = `GNI per Capita Rank Minus HDI Rank`)

gii <- gii %>% rename(giir = `GII Rank`,
                      gii = `Gender Inequality Index (GII)`,
                      maternaldr = `Maternal Mortality Ratio`,
                      teenbr = `Adolescent Birth Rate`,
                      prp = `Percent Representation in Parliament`,
                      edu2F = `Population with Secondary Education (Female)`,
                      edu2M = `Population with Secondary Education (Male)`,
                      workrF = `Labour Force Participation Rate (Female)`,
                      workrM = `Labour Force Participation Rate (Male)`)
# create new variables
gii <- gii %>% mutate(gedu2 = edu2F/edu2M,
                      gworkr = workrF/workrM)
#check new variables
gii %>% head

#join 2 datasets

human <- inner_join(hd, gii, by = "Country")
human %>% head

write_csv(alc, "data/alc.csv")