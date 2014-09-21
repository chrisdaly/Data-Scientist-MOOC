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

# plot 2 - Have total emissions from PM2.5 decreased in the Baltimore City, 
# Maryland (fips == "24510") from 1999 to 2008?

# subset only the Baltimore City data
BC <- subset(NEI, fips == "24510")

# aggregate the emissions by year & rename the columns
BC_by_year <- aggregate(BC$Emissions, list(BC$year), FUN = sum)

# rename the columns & convert the years to characters
names(BC_by_year) <- c("Year", "Emissions")
BC_by_year$Year <- as.character(BC_by_year$Year)

# adjust the margins
par(mar=c(5.1,5,4.1,2.1))

p <- plot(BC_by_year$Year, BC_by_year$Emissions, type = "l", 
     main = expression("Total Emissions from PM"[2.5]*" in Baltimore City"),
     xlab = "Year",
     ylab = (expression("Total" ~ PM[2.5] ~ "Emissions (tonnes)")))

print(p)

# copy plot to png file
dev.copy(png, file = "plot2.png")

# close connection to png device
dev.off()