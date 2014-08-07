# check if a data folder exists; if not then create one
if (!file.exists("data")){dir.create("data")}

# download file and note the time
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileUrl, destfile = "./data/UScommunities.csv")
dateDownloaded <- date()
list.files()

# read the csv file
communitiesData <- read.table("./data/Uscommunities.csv", sep = ",", header = TRUE)

# properties worth $1,000,000 or more (bb property value = 24)
data_ <- communitiesData$VAL >= 24

# omit the NA values
data_ <- na.omit(data_)

# return the sum (aka the number of properties)
sum(data_)

