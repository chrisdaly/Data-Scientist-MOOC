# check if a data folder exists; if not then create one
if (!file.exists("data")) {dir.create("data")}

# file URL & destination file
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
destfile <- "./data/exdata-data-NEI_data.zip"

# download the file & note the time
download.file(fileUrl, destfile)
dateDownloaded <- date()

# read in the data until date
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

# plot 3 - Of the four types of sources indicated by the type (point, nonpoint, 
# onroad, nonroad) variable, which of these four sources have seen decreases in 
# emissions from 1999-2008 for Baltimore City? Which have seen increases in 
# emissions from 1999-2008? Use the ggplot2 plotting system to make a plot 
# answer this question.

library(ggplot2)

# subset only the Baltimore City data
BC <- subset(NEI, fips == "24510")

# aggregate the emissions by source & year
source_ <- aggregate(BC$Emissions, list(BC$type, BC$year), FUN = sum)

# rename the columns
names(source_) <- c("Type", "Year", "Emissions")

p <- qplot(Year, Emissions, color = Type, data = source_, geom = "path") + 
  ggtitle(expression("Total Emissions from PM"[2.5]*" in Baltimore City by Source")) +
  xlab("Year") +
  ylab(expression("Total" ~ PM[2.5] ~ "Emissions (tonnes)"))

print(p)

# copy plot to png file
dev.copy(png, file = "plot3.png")

# close connection to png device
dev.off()