library(GEOquery)
library(tidyr)
library(dplyr)
library(tidyverse)
setwd("C:/Users/ASUS/OneDrive/Desktop/Bioinformatics Coach/Tobacco")

count.table<- read.csv("GSE229462_Supporting_Table_2.csv")
count.table<- count.table%>%
  subset(., select= c(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17))
head(count.table)
colnames(count.table)[1] 

gse<- getGEO(GEO="GSE229462", GSEMatrix = TRUE)
head(gse)

#get metadata
metadata<- pData(phenoData(gse[[1]]))
head(metadata)


metadata.subset<- metadata%>%
  subset(., select=c(1,10,12,17))%>%
  rename(tissue = characteristics_ch1 )%>%
  rename(treatment= characteristics_ch1.2)%>%
  mutate(tissue= gsub("tissue:", "", tissue))%>%
  mutate(treatment= gsub("treatment:", "", treatment))%>%
  mutate(treatment= gsub("untopped", "control", treatment))%>%
  mutate(treatment=trimws(treatment))
  


metadata.subset$samples<- paste(metadata.subset$description)
head(metadata.subset)

# kep first two word
keep_first_two_words <- function(x) {
  paste(strsplit(x, " ")[[1]][1:2], collapse = " ")
}
metadata.subset<-metadata.subset%>%
  mutate(samples = sapply(samples, keep_first_two_words))

metadata.subset$samples<- paste(metadata.subset$samples,metadata.subset$treatment, sep = ".")
head(metadata.subset)

# remove space with "."
metadata.subset<- metadata.subset%>%
  mutate(samples= gsub(" ",".", samples))%>%
  subset(., select=c(4,5,2,3))%>%
  
head(metadata.subset)

# change to long format
count.long<- count.table%>%
  gather(key= "ID", value = "count", -Feature.ID)  
















