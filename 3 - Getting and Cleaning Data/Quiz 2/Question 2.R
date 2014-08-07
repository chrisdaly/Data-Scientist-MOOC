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
# Question: only the data for the probability weights pwgtp1 with ages less than 50?
sqldf("select pwgtp1 from acs where AGEP < 50", drv='SQLite')
sqldf("select * from acs where AGEP < 50", drv='SQLite')
sqldf("select pwgtp1 from acs", drv='SQLite')
sqldf("select * from acs where AGEP < 50 and pwgtp1", drv='SQLite')

# answer = first one