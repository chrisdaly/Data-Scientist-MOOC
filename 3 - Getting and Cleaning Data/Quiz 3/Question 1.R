# check if a data folder exists; if not then create one
if (!file.exists("data")) {dir.create("data")}

# file URL and destination file
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv "
destfile <- "./data/community.csv"

# download the file and note the time
download.file(fileUrl, destfile = destfile)
dateDownloaded <- date()

# from the zip file, read out the containing csv file
data_ <- read.csv(destfile)

# Apply strsplit() to split all the names of the data frame on the characters "wgtp". 
# What is the value of the 123 element of the resulting list?

strsplit(names(data_), "wgtp")[123]

