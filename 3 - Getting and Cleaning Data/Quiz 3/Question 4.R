# check if a data folder exists; if not then create one
if (!file.exists("data")) {dir.create("data")}

# file URL and destination file
fileUrl1 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
fileUrl2 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"

destfile1 <- "./data/GDP.csv"
destfile2 <- "./data/educational.csv"


# download the file and note the time
download.file(fileUrl1, destfile = destfile1)
download.file(fileUrl2, destfile = destfile2)

# download the file and note the time
dateDownloaded <- date()

# read out the containing csv file
GDP <- read.csv(destfile1)
education <- read.csv(destfile2)


# Match the data based on the country shortcode

# merge the two datasets
combined <- merge(GDP, education, by.x="X", by.y="CountryCode")

# convert the GDP and name columns from factor to numeric and character respectively
combined$GDP <- as.numeric(as.character(combined$Gross))
combined$Short.Name <- as.character(combined$Short.Name)

# filter for countries without GDP rank
filter <- !is.na(combined$GDP)

# count the number of countries without a GDP rank
sum(filter)

# create a dataframe of just the country name and GDP rank
DF <- data.frame(combined$Short.Name[filter], combined$GDP[filter])

# order the new dataset by GDP rank
DF <- DF[order(DF$combined.GDP, decreasing = TRUE),]

# get the 13th entry
DF[13, ]


#Question 4
# What is the average GDP ranking for the "High income: OECD" and "High income: nonOECD" group?
# Income.Group

a<- tapply(combined$GDP, combined$Income.Group, na.rm = TRUE, mean)


# Question 5
# Cut the GDP ranking into 5 separate quantile groups. Make a table versus Income.Group. 
# How many countries are Lower middle income but among the 38 nations with highest GDP?

# create a new Data frame which includes income group
DF2 <- data.frame(combined$Short.Name[filter], combined$GDP[filter], combined$Income.Group[filter])
DF2 <- DF2[order(DF2$combined.GDP.filter.),]

# break the GDP into 5 groups
DF2$quantile <- cut(DF2$combined.GDP.filter., breaks =5)

# factor the groups and convert to numeric
DF2$quantile <- factor(DF2$quantile)
DF2$quantile <- as.numeric(f)

result <- (DF2$combined.Income.Group.filter. == "Lower middle income" & DF2$combined.GDP.filter <= 38)

DF2$quantile == 2
