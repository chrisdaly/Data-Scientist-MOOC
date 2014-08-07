library(data.table)

# check if a data folder exists; if not then create one
if (!file.exists("data")){dir.create("data")}

# download file and note the time
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(fileUrl, destfile = "./data/UScommunities2.csv", mode="wb" )
dateDownloaded <- date()
list.files()

# read the csv file
DT <- fread("./data/UScommunities2.csv")

# the following functions produce an error, and not desired output
# rowMeans(DT)[DT$SEX==1]; rowMeans(DT)[DT$SEX==2]
# tapply(DT$pwgtp15,DT$SEX,mean)

# run each expression 1000 times and store the time taken
time_DT <- system.time(for (i in 1:1000) DT[,mean(pwgtp15),by=SEX])
time_sapply <- system.time(for (i in 1:1000) sapply(split(DT$pwgtp15,DT$SEX),mean))
time_tapply <- system.time(for (i in 1:1000) tapply(DT$pwgtp15,DT$SEX,mean))
time_mean1 <-system.time(for (i in 1:1000) mean(DT[DT$SEX==1,]$pwgtp15))     
time_mean2 <-system.time(for (i in 1:1000) mean(DT[DT$SEX==2,]$pwgtp15))
time_mean <- time_mean1 + time_mean2

# sapply is shortest