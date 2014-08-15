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

# Remove the commas from the GDP numbers in millions of dollars and average them. 
# What is the average? 

length(data_$X.3)

# remove the commas
splitted <- gsub(",", "", data_$X.3[5:330])
splitted <- as.numeric(splitted)
GDP <- as.numeric(splitted)
mean(splitted[1:190])

