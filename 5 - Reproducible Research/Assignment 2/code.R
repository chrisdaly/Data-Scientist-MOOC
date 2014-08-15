library(lattice)
library(plyr)

# check if a data folder exists; if not then create one
if (!file.exists("data")) {dir.create("data")}

# file URL and destination file
fileUrl <- "https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2FStormData.csv.bz2"
destfile <- "./data/stormdata.zip"

# download the file and note the time
download.file(fileUrl, destfile = destfile)
dateDownloaded <- date()

bunzip2(destfile, overwrite = TRUE, remove = FALSE)

# from the zip file, read out the containing csv file
data_ <- read.csv(unz(destfile, "stormdata.csv"))


data_ <- read.csv("./data/stormdata.zip.out", nrows = 10000)


# assign variables to the relevant columns
events <- data_$EVTYPE
fatalities <- data_$FATALITIES
injuries <- data_$INJURIES

# convert date into years
years <- as.Date(data_$BGN_DATE, format = "%m/%d/%Y %H:%M:%S")
years <- as.numeric(format(years, "%Y"))

# factor variable to distinguish events
events_factors <- factor(events)

DF <- data.frame(events, fatalities, injuries)

total_fatalities <- tapply(fatalities, events_factors, FUN = sum)
total_injuries <- tapply(injuries, events_factors, FUN = sum)

DF2 <- data.frame(total_fatalities, total_injuries)
DF2 <- data.frame(t(DF2))



injuriesPlot <- qplot(EVTYPE, data = injuries, weight = NUMBER, geom = "histogram", binwidth = 1) + 
  scale_y_continuous("Number of Injuries") + 
  theme(axis.text.x = element_text(angle = 45, 
                                   hjust = 1)) + xlab("Severe weather type") + 
  ggtitle("Total injuries by severe weather event in the U.S. 1990 - 2011")








# plot a histogram of the total number of steps taken each day
histogram(total_injuries,
          col = "lightblue", 
          type = "count")

counts <- table(mtcars$vs, mtcars$gear)
barplot(counts, main="Car Distribution by Gears and VS",
        xlab="Number of Gears", col=c("darkblue","red"),
        legend = rownames(counts))

barplot(DF2)

hail <- 
  
  
  
  
  
  
# Problems
# need to figure out how to properly unzip : https://rpubs.com/jcoutocoursera/24829
# https://rpubs.com/lytemar/24793
  # https://rpubs.com/hamelsmu/24950