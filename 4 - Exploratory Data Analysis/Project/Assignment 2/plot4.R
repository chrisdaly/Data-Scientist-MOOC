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

# plot 4 - Across the United States, how have emissions from coal 
# combustion-related sources changed from 1999-2008?

# subset the source data based on "Coal" appearing in either sector or name columns
coal_filter <- subset(SCC, grepl("Coal", EI.Sector) | grepl("Coal", Short.Name))

# subset the emissions data based on coal source codes
coal_emissions <- subset(NEI, NEI$SCC %in% coal_filter$SCC)

# aggregate the emissions by year
coal <- aggregate(coal_emissions$Emissions, list(coal_emissions$year), FUN = sum)

# rename the columns
names(coal) <- c("Year", "Emissions")

p <- qplot(Year, Emissions, data = coal, geom = "line") + 
  ggtitle(expression("Total Emissions from PM"[2.5]*" from Coal in the US")) +
  xlab("Year") +
  ylab(expression("Total" ~ PM[2.5] ~ "Emissions (tonnes)"))

print(p)

# copy plot to png file
dev.copy(png, file = "plot4.png")

# close connection to png device
dev.off()