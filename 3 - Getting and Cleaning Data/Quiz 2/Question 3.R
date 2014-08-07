library(RMySQL)
library(sqldf)

# check if a data folder exists; if not then create one
if (!file.exists("data")){dir.create("data")}

# download file and note the time
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(fileUrl, destfile = "./data/UScommunities.csv")
dateDownloaded <- date()
list.files()

# read the csv file
acs <- read.table("./data/Uscommunities.csv", sep = ",", header = TRUE)

# setting the driver fixed the errors I was getting
# Question: what is the equivalent function to unique(acs$AGEP)
unique(acs$AGEP)

sqldf("select unique AGEP from acs", drv='SQLite')
sqldf("select unique * from acs", drv='SQLite')
sqldf("select distinct AGEP from acs", drv='SQLite')
sqldf("select AGEP where unique from acs", drv='SQLite')

# answer = third one