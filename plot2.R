library(dplyr)
library(tidyr)
library(lubridate)
rm(list=ls())
setwd("D:/R/JH_Exp/courseProject")
ns<-colnames(read.table("data.txt",skip=0,header=TRUE, nrows=1))
data<-read.csv("data.txt",header=FALSE,skip=66637,nrows=2880)

data<-tbl_df(data)
colnames(data)<-"v1"

names<-strsplit(ns,split="\\.")[[1]]
rm(ns)
data <- separate(data,col="v1",into=names, sep=";", remove=TRUE)
data[,3:9] <- lapply(data[,3:9], as.numeric)
data<-unite(data,col="DateTime",Date,Time,sep=" ")
data$DateTime<-dmy_hms(data$DateTime)

png(filename="plot2.png")
plot(data$DateTime,data$Global_active_power,type="l",xlab="",ylab="Global Active Power (kilowatts)")
dev.off()
