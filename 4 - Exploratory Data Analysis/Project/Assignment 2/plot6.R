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

# plot 6 - Compare emissions from motor vehicle sources in Baltimore City with 
# emissions from motor vehicle sources in Los Angeles County, California 
# (fips == "06037"). Which city has seen greater changes over time in motor 
# vehicle emissions?

library(plyr)

# subset the emissions data based on Balitmore or LA & vehicle codes
motor_filter <- subset(NEI, (fips == "24510" | fips == "06037") & type == "ON-ROAD")

# rename the values, for a more interpretable dataframe & graph
motor_filter <- transform(motor_filter, region = ifelse(fips == "24510", "Baltimore City", 
                                                        "LA County"))
# sum the data by year-region (4x2)
motor <- ddply(motor_filter, .(year, region), function(x) sum(x$Emissions))

# rename the columns
names(motor) <- c("Year", "Region", "Emissions")

p <- qplot(Year, Emissions, data = motor, geom = "line", color = Region) + 
  ggtitle(expression("Total Emissions from PM"[2.5]*" from Vehicles in Baltimore City and LA")) +
  xlab("Year") +
  ylab(expression("Total" ~ PM[2.5] ~ "Emissions (tonnes)")) + 
  facet_wrap(~ Region, scales = "free") + theme(legend.position = "none")

print(p)

# copy plot to png file
dev.copy(png, file = "plot6.png")

# close connection to png device
dev.off()



