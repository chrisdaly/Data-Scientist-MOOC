# check if a data folder exists; if not then create one
if (!file.exists("data")){dir.create("data")}

# download file and note the time
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for "
download.file(fileUrl, destfile = "./data/cpc.for")
dateDownloaded <- date()
list.files()

# read the fixed width formatted file, specify 
cpc <- read.fwf("./data/cpc.for", widths = c(10, 5, 4, 1, 4, 1, 7, 1, 4, 1, 7, 1, 4, 1, 7), skip = 4)

# Question: report the sum of the numbers in the fourth column

# get the 4th column (Nino3, SST)
col4 <- cpc$V9

# convert the type from factor to numeric and get the sum
sum(as.numeric(cpc$V3))
sum(as.numeric(cpc$V5))
sum(as.numeric(cpc$V7))
sum(as.numeric(cpc$V9))
sum(as.numeric(cpc$V11))
sum(as.numeric(cpc$V13))
sum(as.numeric(cpc$V15))
