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

png("plot4.png",width=480,height=480,units="px")
par(mfrow=c(2,2))
plot(data$DateTime,data$Global_active_power,type="l",xlab="",ylab="Global Active Power (kilowatts)")
plot(data$DateTime,data$Voltage,type="l",xlab="datetime",ylab="Voltage")
plot(data$DateTime,data$Sub_metering_1,type="l",xlab="",ylab="Energy sub metering")
lines(data$DateTime,data$Sub_metering_2,col="red")
lines(data$DateTime,data$Sub_metering_3,col="blue")
legend("topright", lty=1, col = c("black","red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))
plot(data$DateTime,data$Global_reactive_power,type="l",xlab="datetime",ylab="Global_reactive_power")
dev.off()
