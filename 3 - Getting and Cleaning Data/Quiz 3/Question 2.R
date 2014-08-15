library(jpeg)

# check if a data folder exists; if not then create one
if (!file.exists("data")) {dir.create("data")}

# file URL and destination file
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
destfile <- "./data/jeff.jpg"

# download the file and note the time
download.file(fileUrl, destfile = destfile, mode = "wb")
dateDownloaded <- date()

# load the jpg fi
img <- readJPEG(destfile, native = TRUE)
