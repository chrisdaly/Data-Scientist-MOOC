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


# plot 1 - Have total emissions from PM2.5 decreased in the United States 
# 1999-2008?

# aggregate the emissions by year & rename the columns
emissions_by_year <- aggregate(NEI$Emissions, by = list(NEI$year), FUN = sum)

# rename the columns & convert the years to characters
names(emissions_by_year) <- c("Year", "Emissions")
emissions_by_year$Year <- as.character(emissions_by_year$Year)

plot(emissions_by_year$Year, emissions_by_year$Emissions/10^6, type = "l", 
     main = expression("Total Emissions from PM"[2.5]*" in the US"),
     xlab = "Year", 
     ylab = (expression("Total" ~ PM[2.5] ~ "Emissions (million tonnes)")))



# plot 2 - Have total emissions from PM2.5 decreased in the Baltimore City, 
# Maryland (fips == "24510") from 1999 to 2008?

# subset only the Baltimore City data
BC <- subset(NEI, fips == "24510")

# aggregate the emissions by year & rename the columns
BC_by_year <- aggregate(BC$Emissions, list(BC$year), FUN = sum)

# rename the columns & convert the years to characters
names(BC_by_year) <- c("Year", "Emissions")
BC_by_year$Year <- as.character(BC_by_year$Year)

plot(BC_by_year$Year, BC_by_year$Emissions, type = "l", 
     main = expression("Total Emissions from PM"[2.5]*" in Baltimore City"),
     xlab = "Year",
     ylab = (expression("Total" ~ PM[2.5] ~ "Emissions (tonnes)")))


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
  ggtitle(expression("Total Emissions from PM"[2.5]*" in Baltimore City by Source")) +
  xlab("Year") +
  ylab(expression("Total" ~ PM[2.5] ~ "Emissions (tonnes)"))


# plot 5 - How have emissions from motor vehicle sources changed from 1999-2008 
# in Baltimore City?

# subset the source data based on "On-Road" appearing in sector column
motor_filter <- subset(SCC, grepl("On-Road", EI.Sector))

# subset the emissions data based on Balitmore & coal source codes
motor_filter2 <- subset(NEI, fips == "24510" & NEI$SCC %in% motor_filter$SCC)

# aggregate the emissions by year
motor <- aggregate(motor_filter2$Emissions, list(motor_filter2$year), FUN = sum)

# rename the columns
names(motor) <- c("Year", "Emissions")

p <- qplot(Year, Emissions, data = motor, geom = "line") + 
  ggtitle(expression("Total Emissions from PM"[2.5]*" in Baltimore City by Source")) +
  xlab("Year") +
  ylab(expression("Total" ~ PM[2.5] ~ "Emissions (tonnes)")) 


# plot 6 - Compare emissions from motor vehicle sources in Baltimore City with 
# emissions from motor vehicle sources in Los Angeles County, California 
# (fips == "06037"). Which city has seen greater changes over time in motor 
# vehicle emissions?

# subset the emissions data based on Balitmore or LA & vehicle codes
motor_filter <- subset(NEI, (fips == "24510" | fips == "06037") & type == "ON-ROAD")

# rename the values, for a more interpretable dataframe & graph
motor_filter <- transform(motor_filter, region = ifelse(fips == "24510", "Baltimore City", 
                                              "Los Angeles County"))

# sum the data by year-region (4x2)
motor <- ddply(motor_filter, .(year, region), function(x) sum(x$Emissions))

# rename the columns
names(motor) <- c("Year", "Region", "Emissions")

p <- qplot(Year, Emissions, data = motor, geom = "line", color = Region) + 
  ggtitle(expression("Total Emissions from PM"[2.5]*" in Baltimore City by Source")) +
  xlab("Year") +
  ylab(expression("Total" ~ PM[2.5] ~ "Emissions (tonnes)"))

# split the data
motor_BC <- subset(motor, Region == "Baltimore City")
motor_LA <- subset(motor, Region == "Los Angeles County")

BC_min <- min(motor_BC$Emissions); BC_max <- max(motor_BC$Emissions)
LA_min <- min(motor_LA$Emissions); LA_max <- max(motor_LA$Emissions)


p + geom_hline(aes(yintercept = BC_min), linetype = "dashed") + 
  geom_hline(aes(yintercept = BC_max ), linetype = "dashed") + 
  geom_hline(aes(yintercept = LA_min), linetype = "dashed") + 
  geom_hline(aes(yintercept = LA_max ), linetype = "dashed") 
  
