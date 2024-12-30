library(tidyr)
library(tidyverse)
library(dplyr)
library(ggplot2)
setwd("C:/Users/ASUS/OneDrive/Desktop/Bioinformatics Coach/Tobacco")
map<- read.csv("GSE229462_Supporting_Table_1.csv")
head(map)

map1<- map%>%
  rename("mapped_reads"= "Mapped.Reads....")%>%
  rename("mapped_to_genes"= "Mapped.to.Genes....")
head(map1)  

map1$type<- paste(map1$Sample.Name)
map1$tissue<- paste(map$Sample.Name)
head(map1)

map1<-map1%>%
  mutate(type= word(type, 1))%>%
  mutate(tissue= word(tissue,2))

# explore
explore1<- map1%>%
  group_by(type,tissue)%>%
  summarize("mean_mapped_to_genes%" = mean(mapped_to_genes))

# explore
explore2<- map1%>%
  group_by(tissue)%>%
  summarize("mean_mapped_reads%" = mean(mapped_reads))

#explore
map1%>%
  group_by(type)%>%
  summarize("mean_mapped_reads%"= mean(mapped_reads))

# plots 

# bar plots
map1%>%
  ggplot(., aes(x= tissue, y= mapped_reads))+
  geom_col()+
  theme_bw()

#box plot
map1%>%
  ggplot(., aes(x= type, y= mapped_reads))+
  geom_boxplot()+
  theme_bw()


# density plot
map1%>%
  ggplot(., aes(x= mapped_reads, fill= type))+
  geom_density(alpha=0.4)+
  theme_bw()

# scatter plot of type of line

scatter<- map1%>%
  spread(key= tissue, value= mapped_reads)
  
map1%>%
  ggplot(., aes(x= mapped_to_genes, y= mapped_reads, color= type))+
  geom_point(alpha= 0.6)+
  theme_bw()

#geom_smooth(method = "lm", se= FALSE)




























  