library(xlsx)

# check if a data folder exists; if not then create one
if (!file.exists("data")){dir.create("data")}

# download file and note the time
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
download.file(fileUrl, destfile = "./data/NaturalGas.xlsx", mode="wb" )
dateDownloaded <- date()
list.files()

# NOTE: this code didn't work and I instead converted the file to csv usign open office
# read the  rows 18-23 and columns 7-15
# colIndex <- 18:23
# rowIndex <- 7:15
# dat <- read.xlsx("./data/NaturalGas.xlsx", sheetIndex=1, header=TRUE, colIndex=colIndex, rowIndex=rowIndex)

# read in the data
dat_ <- read.table("./data/NaturalGas2.csv", sep = ",", header = TRUE)

# compute the answer
ans_ <- sum(dat_$Zip*dat_$Ext, na.rm=T)