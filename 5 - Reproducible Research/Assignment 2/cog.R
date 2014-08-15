library(ggplot2)
library(plyr)
require(gridExtra)
library(sqldf)

data <- read.csv("./data/stormdata.zip.out", nrows = 10000)


data$EVTYPE<-toupper(data$EVTYPE)
data$EVTYPE<-gsub(" ","/", data$EVTYPE , fixed=TRUE)
data$EVTYPE<-gsub("//","/", data$EVTYPE , fixed=TRUE)
data$EVTYPE<-gsub(",","/", data$EVTYPE , fixed=TRUE)
data$EVTYPE<-gsub("-","/", data$EVTYPE , fixed=TRUE)

injuries1<-aggregate(data[, "INJURIES"], by = list(data$EVTYPE), FUN = "sum",na.rm=TRUE)
colnames(injuries1)<-c("EVTYPE", "NUMBER")
injuries1<-head(arrange(injuries1, injuries1[, 2], decreasing = T), n=15)

fatalities1<-aggregate(data[, "FATALITIES"], by = list(data$EVTYPE), FUN = "sum",na.rm=TRUE)
colnames(fatalities1)<-c("EVTYPE", "NUMBER")
fatalities1<-head(arrange(fatalities1, fatalities1[, 2], decreasing = T), n=15)


injuriesPlot <- qplot(EVTYPE, data = injuries, weight = NUMBER, geom = "histogram", binwidth = 1) + 
  scale_y_continuous("Number of Injuries") + 
  theme(axis.text.x = element_text(angle = 45, 
                                   hjust = 1)) + xlab("Severe weather type") + 
  ggtitle("Total injuries by severe weather event in the U.S. 1990 - 2011")

fatalitiesPlot <- qplot(EVTYPE, data = fatalities, weight = NUMBER, geom = "histogram", binwidth = 1) + 
  scale_y_continuous("Number of Fatalities") + 
  theme(axis.text.x = element_text(angle = 45, 
                                   hjust = 1)) + xlab("Severe weather type") + 
  ggtitle("Total fatalities by severe weather event in the U.S. 1990 - 2011")

injuriesPlot

qplot(injuries)
