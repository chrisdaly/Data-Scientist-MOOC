# check if a data folder exists; if not then create one
if (!file.exists("data")) {dir.create("data")}

# file URL and destination file
fileUrl1 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
fileUrl2 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"

destfile1 <- "./data/GDP.csv"
destfile2 <- "./data/educational.csv"


# download the file and note the time
download.file(fileUrl1, destfile = destfile1)
download.file(fileUrl2, destfile = destfile2)

# download the file and note the time
dateDownloaded <- date()

# read in the csv files
GDP <- read.csv(destfile1)
education <- read.csv(destfile2)

# Match the data based on the country shortcode
# Of the countries for which the end of the fiscal year is available, how many end in June? 

# merge the two datasets
combined <- merge(GDP, education, by.x="X", by.y="CountryCode")

specialNotes <- combined$Special.Notes

length(grep(("Fiscal year end: June"), specialNotes))

