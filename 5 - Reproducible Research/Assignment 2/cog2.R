Weather impact on Health and Economic damage


data <- read.table("repdata-data-StormData.csv", quote='"', sep =',', header=TRUE, row.names=NULL)

data <- read.csv("./data/stormdata.zip.out", nrows = 2000)


mul <- function(damage, exp){
  if(toupper(exp)=="K"){
    as.numeric(damage)*1000
  }
  else if(toupper(exp) == "M"){
    as.numeric(damage)*1000000
  }
  else if(toupper(exp)=="B"){
    as.numeric(damage)*1000000000
  }
  else{
    as.numeric(damage)
  }
}

propDmg <- apply(data[, c('PROPDMG', 'PROPDMGEXP')], 1, function(y) mul(y['PROPDMG'], y['PROPDMGEXP']))
cropDmg <- apply(data[, c('CROPDMG', 'CROPDMGEXP')], 1, function(y) mul(y['CROPDMG'], y['CROPDMGEXP']))

compactData <- data.frame(
  year=factor(format(as.Date(data$BGN_DATE, "%m/%d/%Y"), "%Y")), 
  state=data$STATE, 
  eventType=data$EVTYPE,
  fatalities=data$FATALITIES, 
  injuries=data$INJURIES, 
  propertyDamage=propDmg,
  cropDamage=cropDmg)


#removing rows with no damage done

compactData <- compactData[compactData$fatalities != 0 | compactData$injuries != 0 | compactData$propertyDamage != 0 | compactData$cropDamage != 0,]

str(compactData)


eventTypes <- aggregate(compactData$fatalities + compactData$injuries, by=list(compactData$eventType), FUN=sum)
colnames(eventTypes) <- c('typeOfEvent', 'Damage')

eventTypes <- eventTypes[order(-eventTypes[, 2]),]

library(ggplot2)
ggplot(data=eventTypes[1:10,], aes(x=typeOfEvent, y=Damage, fill=typeOfEvent)) + geom_bar(stat='identity') + ylab("Damage done to health") +
  xlab("Event Type") + theme(axis.ticks = element_blank(), axis.text = element_blank())
plot of chunk unnamed-chunk-3

eventTypesEconomy <- aggregate(compactData$propertyDamage + compactData$cropDamage, by=list(compactData$eventType), FUN=sum)
colnames(eventTypesEconomy) <- c('typeOfEvent', 'Damage')


ggplot(data=eventTypesEconomy[1:20,], aes(x=typeOfEvent, y=Damage, fill=typeOfEvent)) + 
  geom_bar(width=1, stat='identity') + 
  ylab("Property and Crop Damage") + 
  xlab("Event Type") + 
  theme(axis.ticks = element_blank(), axis.text = element_blank())