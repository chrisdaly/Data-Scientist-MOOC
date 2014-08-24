library(ggplot2)
library(Hmisc)
library(knitr)
library(reshape2)

# check if a data folder exists; if not then create one
if (!file.exists("data")) {dir.create("data")}

# file URL and destination file
fileUrl <- "https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2FStormData.csv.bz2"
destfile <- "./data/stormdata.zip"

# download the file and note the time
download.file(fileUrl, destfile = destfile)
dateDownloaded <- date()

# read the csv file
bz
data_ <- read.csv("./data/stormdata.zip", nrows =2)
# subset the data with only the relevant rows
data_ = subset(data_, select = c("EVTYPE","FATALITIES","INJURIES","PROPDMG", "PROPDMGEXP", "CROPDMG", "CROPDMGEXP"))

data_ <- read.csv("./data/stormdata.csv.bz2", nrows = 2, header=TRUE)
data_ <- read.csv(bzfile("./data/stormdata.csv.bz2"), nrows = 2, header=TRUE)

# str(data_)

# convert date into years
# years <- as.Date(data_$BGN_DATE, format = "%m/%d/%Y %H:%M:%S")
# years <- as.numeric(format(years, "%Y"))
# 
# # plot a histogram of the years
# hist(years)

# assign variables to the relevant columns
events <- data_$EVTYPE
fatalities <- data_$FATALITIES
injuries <- data_$INJURIES

# standardize the event types and group similar ones together (985 - 252 factors)
events <- sapply(events, FUN = function(x){
  x <- tolower(x)
  if (grepl("storm surge", x)){
    return("Storm surge")
  }
  if (grepl("flood", x)){
    return("Flood")
  }
  if (grepl("tornado", x)){
    return("Tornado")
  }
  if (grepl("snow|ice|wintry|freez|blizzard|cold|winter", x)){
    return("Wintry")
  }
  if (grepl("rain|shower", x)){
    return("Rain")
  }
  if (grepl("thunder|lightning", x)){
    return("Lightning")
  } 
  if (grepl("wind", x)){
    return("Wind")
  } 
  if (grepl("hurricane|tropical|typhoon", x)){
    return("Hurricane")
  }
  if (grepl("dry|drought", x)){
    return("Dry weather")
  }
  if (grepl("heat|warm", x)){
    return("Heat")
  }
  if (grepl("hail", x)){
    return("Hail")
  }
  if (grepl("fire", x)){
    return("Fire")
  }
  else{
    return(capitalize(x))
  }
})

# factor variable to distinguish events
events_factors <- factor(events)

# sum up the fatalities and injuries for each event
fatalities_sum <- aggregate(fatalities, list(events_factors), sum)
injuries_sum <- aggregate(injuries, list(events_factors), sum)
names(fatalities_sum) <- c("Event", "Count"); names(injuries_sum) <- c("Event", "Count")

# create a DF of Event, Injuries, Fatalities
health <- data.frame(fatalities_sum$Event, injuries_sum$Count, fatalities_sum$Count)
names(health) <- c("Event", "Injuries", "Fatalities")

# reorder by injuries and fatalities, then take the top 10 rows
health <- health[with(health, order(-Injuries, -Fatalities)), ][1:10,]

# reshape to long format (for stacked histogram)
health <- melt(health); names(health) <- c("Event", "variable", "value")

# add a column to sort the histogram by size
health$Event2 <- reorder(health$Event, health$value)

# function to combine the coefficient and exponent
convertUnits <- function(coeff, expon){
  
  if (is.na(expon)){
    as.numeric(coeff)
  }
  else if (toupper(expon)== "K"){
    as.numeric(coeff)*10^3
  }
  else if (toupper(expon) == "M"){
    as.numeric(coeff)*10^6
  }
  else if (toupper(expon)== "B"){
    as.numeric(coeff)*10^9
  }
  else{
    as.numeric(coeff)
  }
}
# assign variables to the relevant columns
prop_dmg <- apply(data_[, c('PROPDMG', 'PROPDMGEXP')], 1, function(y) convertUnits(y['PROPDMG'], y['PROPDMGEXP']))
crop_dmg <- apply(data_[, c('CROPDMG', 'CROPDMGEXP')], 1, function(y) convertUnits(y['CROPDMG'], y['CROPDMGEXP']))

# sum up the property and crop damage for each event
prop_sum <- aggregate(prop_dmg, list(events_factors), sum)
crop_sum <- aggregate(crop_dmg, list(events_factors), sum)
names(prop_sum) <- c("Event", "Count"); names(crop_sum) <- c("Event", "Count")

# create a DF of Event, Crop damage, Property damage
economic <- data.frame(prop_sum$Event, prop_sum$Count, crop_sum$Count)
names(economic) <- c("Event", "Property", "Crop")

# reorder by injuries and fatalities, then take the top 10 rows
economic <- economic[with(economic, order(-Property, -Crop)), ][1:10,]

# reshape to long format (for stacked histogram)
economic <- melt(economic); names(economic) <- c("Event", "variable", "value")

# add a column to sort the histogram by size
economic$Event2 <- reorder(economic$Event, economic$value)

# plot the graphs
p1 <- ggplot(data = health, aes(x = Event2, y = value, fill = variable))
p1 + geom_bar(stat ='identity') + 
  labs(title = '10 Most Harmful Types of Weather\n Measured by Fatalities & Injuries 1950 - 2011',
       y = 'Number of People', x = 'Weather Event', fill = 'Type of harm')

p2 <- ggplot(data = economic, aes(x = Event2, y = value/10^9, fill = variable))
p2 + geom_bar(stat ='identity') + 
labs(title = '10 Most Harmful Types of Weather\n Measured by Property and Crop Damage 1950 - 2011', 
     y = 'Damage (Billion $)', x = 'Weather Event', fill = 'Type of damage') 
