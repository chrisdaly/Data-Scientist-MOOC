library(XML)

# check if a data folder exists; if not then create one
if (!file.exists("data")){dir.create("data")}

# parse the XML from the URL
fileUrl <- "http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
doc <- xmlTreeParse(fileUrl, useInternal=TRUE)

# get the root node (response tag)
rootNode <- xmlRoot(doc)
xmlName(rootNode)

# get the row tag
row <- rootNode[[1]]

# find every zipcode tag
zipcodes <- xpathSApply(row,'//zipcode', xmlValue)

# filter by specific zipcode
zipcodes <- zipcodes[zipcodes==21231]

# return the number of zipcodes left
length(zipcodes)



