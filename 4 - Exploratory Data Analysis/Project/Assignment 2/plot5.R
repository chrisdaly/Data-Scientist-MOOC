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
  ggtitle(expression("Total Emissions from PM"[2.5]*" from Vehicles in Baltimore City")) +
  xlab("Year") +
  ylab(expression("Total" ~ PM[2.5] ~ "Emissions (tonnes)")) 

print(p)

# copy plot to png file
dev.copy(png, file = "plot5.png")

# close connection to png device
dev.off()