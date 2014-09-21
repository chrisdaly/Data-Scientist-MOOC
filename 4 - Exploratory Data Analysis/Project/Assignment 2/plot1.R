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

# adjust the margins
par(mar=c(5.1,5,4.1,2.1))
    
p <- plot(emissions_by_year$Year, emissions_by_year$Emissions/10^6, type = "l", 
     main = expression("Total Emissions from PM"[2.5]*" in the US"),
     xlab = "Year", 
     ylab = (expression("Total" ~ PM[2.5] ~ "Emissions (million tonnes)")))

print(p)

# copy plot to png file
dev.copy(png, file = "plot1.png")

# close connection to png device
dev.off()