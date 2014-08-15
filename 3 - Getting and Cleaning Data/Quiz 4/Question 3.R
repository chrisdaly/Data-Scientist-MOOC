library(stringr)

# check if a data folder exists; if not then create one
if (!file.exists("data")) {dir.create("data")}

# file URL and destination file
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv "
destfile <- "./data/GDP.csv"

# download the file and note the time
download.file(fileUrl, destfile = destfile)
dateDownloaded <- date()

# from the zip file, read out the containing csv file
data_ <- read.csv(destfile)

countryNames <- data_$X.2

grep("*United",countryNames)